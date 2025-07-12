import 'package:flutter/material.dart';

class PackDetailScreen extends StatelessWidget {
  const PackDetailScreen({super.key});
  static const _primary = Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    final pack = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(backgroundColor: _primary, title: Text(pack['title'])),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(pack['image'], height: 240, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 24),
          Text(pack['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Just ₹${pack['price']}', style: const TextStyle(fontSize: 20, color: Colors.black54)),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => Navigator.pushNamed(context, '/confirmation', arguments: pack['title']),
              child: const Text('Reserve Now'),
            ),
          ),
        ],
      ),
    );
  }
}
