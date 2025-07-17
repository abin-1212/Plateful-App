// Mock data for food packs and testimonials for Plateful

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> get packsCollection => firestore.collection('packs');
CollectionReference<Map<String, dynamic>> get partnersCollection => firestore.collection('partners');
CollectionReference<Map<String, dynamic>> get usersCollection => firestore.collection('users');

Future<List<Map<String, dynamic>>> fetchPacks() async {
  final snapshot = await packsCollection.get();
  return snapshot.docs.map((doc) => doc.data()).toList();
}

Future<List<Map<String, dynamic>>> fetchPartners() async {
  final snapshot = await partnersCollection.get();
  return snapshot.docs.map((doc) => doc.data()).toList();
}

Future<List<Map<String, dynamic>>> fetchUsers() async {
  final snapshot = await usersCollection.get();
  return snapshot.docs.map((doc) => doc.data()).toList();
}

final List<Map<String, dynamic>> mockPacks = [
  {
    'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80',
    'title': 'Protein Power Pack',
    'desc': 'High-protein meals for fitness lovers.',
    'price': '₹499',
    'offer': '10% OFF',
  },
  {
    'image': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80',
    'title': 'Vegan Delight',
    'desc': 'Delicious plant-based food packs.',
    'price': '₹399',
    'offer': '15% OFF',
  },
  {
    'image': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80',
    'title': 'Family Feast',
    'desc': 'Perfect for sharing with loved ones.',
    'price': '₹899',
    'offer': '20% OFF',
  },
];

final List<Map<String, dynamic>> mockTestimonials = [
  {
    'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
    'name': 'Amit S.',
    'testimonial': 'Plateful made healthy eating so easy! The packs are delicious and always fresh.',
    'rating': 5,
  },
  {
    'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
    'name': 'Priya K.',
    'testimonial': 'Love the variety and convenience. Highly recommend to anyone!',
    'rating': 5,
  },
  {
    'avatar': 'https://randomuser.me/api/portraits/men/65.jpg',
    'name': 'Rahul D.',
    'testimonial': 'Great service and tasty food. My family loves the Family Feast pack!',
    'rating': 4,
  },
]; 