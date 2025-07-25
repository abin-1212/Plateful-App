import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> initialize() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyA0QfAhNXZGO7mqDZcVzlEFYaJqp9RAhuA',
          appId: '1:1009788777874:web:376cde409e62a0ed0a7d4b',
          messagingSenderId: '1009788777874',
          projectId: 'plateful-8c60b',
          authDomain: 'plateful-8c60b.firebaseapp.com',
          storageBucket: 'plateful-8c60b.firebasestorage.app',
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  // Sign up with email and password, save user to Firestore
  Future<User?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      await saveUserToFirestore(
        uid: user.uid,
        name: name,
        email: email,
        role: role,
      );
    }
    return user;
  }

  // Sign in with email and password
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  // Sign out
  Future<void> signOut() async {
    await auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // Get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.data()?['role'] as String?;
  }

  // Fetch user model from Firestore
  Future<UserModel?> getUserModel(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Save user to Firestore
  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    required String role,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Stream for auth state changes
  Stream<User?> authStateChanges() => auth.authStateChanges();

  // Stream food packs (for user dashboard)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamFoodPacks() {
    return firestore.collection('food_packs').orderBy('createdAt', descending: true).snapshots();
  }

  // Stream users (for admin dashboard)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUsers() {
    return firestore.collection('users').snapshots();
  }

  // Stream vendors (for admin dashboard)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamVendors() {
    return firestore.collection('users').where('role', isEqualTo: 'vendor').snapshots();
  }

  // Add food pack (for vendor)
  Future<void> addFoodPack(Map<String, dynamic> data) async {
    await firestore.collection('food_packs').add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update food pack
  Future<void> updateFoodPack(String packId, Map<String, dynamic> data) async {
    await firestore.collection('food_packs').doc(packId).update(data);
  }

  // Delete food pack
  Future<void> deleteFoodPack(String packId) async {
    await firestore.collection('food_packs').doc(packId).delete();
  }

  // Reserve food pack (for user)
  Future<void> reserveFoodPack({
    required String packId,
    required String userId,
  }) async {
    await firestore.collection('reservations').add({
      'packId': packId,
      'userId': userId,
      'reservedAt': FieldValue.serverTimestamp(),
    });
    // Optionally update food pack status
    await firestore.collection('food_packs').doc(packId).update({'reserved': true, 'reservedBy': userId});
  }

  // Stream notifications (for all roles)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications(String userId) {
    return firestore.collection('notifications')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots();
  }

  // Add feedback (for user after pickup)
  Future<void> addFeedback({
    required String userId,
    required String packId,
    required int rating,
    required String comment,
  }) async {
    await firestore.collection('feedback').add({
      'userId': userId,
      'packId': packId,
      'rating': rating,
      'comment': comment,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Stream feedback (for admin/vendor insights)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamFeedback({String? packId, String? vendorId}) {
    var query = firestore.collection('feedback').orderBy('createdAt', descending: true);
    if (packId != null) {
      query = query.where('packId', isEqualTo: packId);
    }
    if (vendorId != null) {
      query = query.where('vendorId', isEqualTo: vendorId);
    }
    return query.snapshots();
  }
} 