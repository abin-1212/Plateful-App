import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
  }

  // Auth
  static Future<User?> signInWithEmail(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  static Future<User?> signUpWithEmail(String email, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  // Firestore
  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(String collection, String docId) async {
    return FirebaseFirestore.instance.collection(collection).doc(docId).get();
  }

  static Future<void> setDocument(String collection, String docId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc(docId).set(data);
  }

  static Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc(docId).update(data);
  }

  static Future<void> deleteDocument(String collection, String docId) async {
    await FirebaseFirestore.instance.collection(collection).doc(docId).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream(String collection) {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }

  // Storage
  static Future<String> uploadFile(String path, String fileName, List<int> bytes) async {
    final ref = FirebaseStorage.instance.ref().child(path).child(fileName);
    final uploadTask = await ref.putData(bytes);
    return await uploadTask.ref.getDownloadURL();
  }

  // Messaging
  static Future<String?> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
} 