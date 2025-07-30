import 'package:flutter/material.dart';

class InformasiScreen extends StatelessWidget {
  const InformasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Aplikasi')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Aplikasi Kampusku merupakan aplikasi yang dapat membantu kamu dalam mencari informasi tentang kampus kamu.',
          style: TextStyle(fontSize: 16),
        ),
      ), 
    );
  }
}