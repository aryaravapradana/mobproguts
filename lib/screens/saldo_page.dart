import 'package:flutter/material.dart';
import '../models/user.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({super.key});

  @override
  State<SaldoPage> createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  final topUpController = TextEditingController();

  void topUp() {
    final amount = int.tryParse(topUpController.text) ?? 0;
    if (amount > 0) {
      setState(() {
        currentUser.saldo += amount;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil top-up Rp$amount')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saldo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Saldo Saat Ini: Rp${currentUser.saldo}"),
            TextField(
              controller: topUpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan nominal top up'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: topUp, child: const Text("Top Up")),
          ],
        ),
      ),
    );
  }
}
