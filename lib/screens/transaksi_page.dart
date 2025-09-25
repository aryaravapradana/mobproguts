import 'package:flutter/material.dart';
import 'package:project_midterms/data/transaction_data.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: ListView.builder(
        itemCount: dummyTransaksi.length,
        itemBuilder: (context, index) {
          final trx = dummyTransaksi[index];
          final points = (trx.amount / 1000).floor();
          return ListTile(
            title: Text(trx.title),
            subtitle: Text("Rp${trx.amount} (+${points} pts)"),
            trailing: Text("${trx.date.day}/${trx.date.month}/${trx.date.year}"),
          );
        },
      ),
    );
  }
}