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
          return ListTile(
            title: Text(trx.title),
            subtitle: Text("Rp${trx.amount}"),
            trailing: Text("${trx.date.day}/${trx.date.month}/${trx.date.year}"),
          );
        },
      ),
    );
  }
}