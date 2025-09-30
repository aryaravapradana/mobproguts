import 'package:flutter/material.dart';
import 'package:project_midterms/data/transaction_data.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart'; // Import AppColors

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi'), backgroundColor: AppColors.black,),
      body: ListView.builder(
        itemCount: dummyTransaksi.length,
        itemBuilder: (context, index) {
          final trx = dummyTransaksi[index];
          
          String subtitleText = '';
          Color subtitleColor = AppColors.white.withAlpha(153);

          String monetaryText = '';
          if (trx.amount > 0) {
            monetaryText = "Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(trx.amount)}";
          }

          String pointsText = '';
          if (trx.pointsChange != null) {
            if (trx.pointsChange! > 0) {
              pointsText = "+${trx.pointsChange} Poin";
              subtitleColor = Colors.green; // Earned points
            } else if (trx.pointsChange! < 0) {
              pointsText = "${trx.pointsChange} Poin"; // Already has '-' sign
              subtitleColor = Colors.red; // Redeemed points
            }
          }

          if (monetaryText.isNotEmpty && pointsText.isNotEmpty) {
            subtitleText = "$monetaryText ($pointsText)";
          } else if (monetaryText.isNotEmpty) {
            subtitleText = monetaryText;
          } else if (pointsText.isNotEmpty) {
            subtitleText = pointsText;
          } else {
            subtitleText = "No details"; // Fallback
          }

          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(trx.title, style: const TextStyle(color: AppColors.white)),
              subtitle: Text(subtitleText, style: TextStyle(color: subtitleColor)),
              trailing: Text(DateFormat('d/M/y HH:mm').format(trx.date), style: TextStyle(color: AppColors.white.withAlpha(153))),
            ),
          );
        },
      ),
    );
  }
}