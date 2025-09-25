import 'package:flutter/material.dart';
import 'package:project_midterms/data/redeem_history_data.dart';

class RedeemHistoryPage extends StatelessWidget {
  const RedeemHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Redeem')),
      body: ListView.builder(
        itemCount: redeemedVouchers.length,
        itemBuilder: (context, index) {
          final voucher = redeemedVouchers[index];
          return ListTile(
            title: Text(voucher.title),
            subtitle: Text("Cost: ${voucher.cost} poin"),
            trailing: Text(voucher.date != null ? "${voucher.date!.day}/${voucher.date!.month}/${voucher.date!.year}" : ""),
          );
        },
      ),
    );
  }
}
