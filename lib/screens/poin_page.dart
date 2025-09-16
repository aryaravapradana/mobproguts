import 'package:flutter/material.dart';

class PoinPage extends StatelessWidget {
  const PoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Poin')),
      body: const Center(child: Text('Poin: 1500 (Dummy Data)')),
    );
  }
}
