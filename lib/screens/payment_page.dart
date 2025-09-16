import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/transaksi.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final amountController = TextEditingController();

  void makePayment() {
    final amount = int.tryParse(amountController.text) ?? 0;
    if (amount > 0 && currentUser.saldo >= amount) {
      setState(() {
        currentUser.saldo -= amount;
        currentUser.poin += (amount ~/ 1000); // contoh: 1 poin per 1000
        currentUser.spending += amount;
        dummyTransaksi.insert(0, Transaksi(title: "Pembayaran", amount: amount, date: DateTime.now()));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembayaran Rp$amount berhasil')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo tidak cukup!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Saldo: Rp${currentUser.saldo}"),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nominal Pembayaran'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: makePayment, child: const Text("Bayar")),
          ],
        ),
      ),
    );
  }
}
