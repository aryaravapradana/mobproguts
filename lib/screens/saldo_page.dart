import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import '../models/user.dart';

class SaldoPage extends StatefulWidget {
  final UserModel user;
  const SaldoPage({super.key, required this.user});

  @override
  State<SaldoPage> createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  final topUpController = TextEditingController();

  void topUp() {
    final amount = int.tryParse(topUpController.text) ?? 0;
    if (amount > 0) {
      setState(() {
        widget.user.saldo += amount;
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
            Text("Saldo Saat Ini: Rp${widget.user.saldo}", style: TextStyle(color: AppColors.white, fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: topUpController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColors.white),
              decoration: const InputDecoration(
                labelText: 'Masukkan nominal top up',
                labelStyle: TextStyle(color: AppColors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: topUp, 
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
              child: const Text("Top Up", style: TextStyle(color: AppColors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
