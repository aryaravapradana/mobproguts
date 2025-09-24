import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/data/voucher_data.dart';
import '../models/voucher.dart';
import '../models/user.dart';

class VoucherPage extends StatefulWidget {
  final UserModel user;
  const VoucherPage({super.key, required this.user});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  void redeemVoucher(Voucher voucher) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redeeming voucher...')),
    );
    if (widget.user.poin >= voucher.cost) {
      setState(() {
        widget.user.poin -= voucher.cost;
        redeemedVouchers.add(Voucher(title: voucher.title, cost: voucher.cost, date: DateTime.now()));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil redeem: ${voucher.title}')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Poin tidak cukup!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Voucher')),
      body: ListView.builder(
        itemCount: dummyVouchers.length,
        itemBuilder: (context, index) {
          final voucher = dummyVouchers[index];
          return ListTile(
            title: Text(voucher.title, style: TextStyle(color: AppColors.white)),
            subtitle: Text("Harga: ${voucher.cost} poin", style: TextStyle(color: AppColors.white.withAlpha(153))),
            trailing: ElevatedButton(
              onPressed: () => redeemVoucher(voucher),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
              child: const Text("Redeem", style: TextStyle(color: AppColors.black)),
            ),
          );
        },
      ),
    );
  }
}