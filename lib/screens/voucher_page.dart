import 'package:flutter/material.dart';
import '../models/voucher.dart';
import '../models/user.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  void redeemVoucher(Voucher voucher) {
    if (currentUser.poin >= voucher.cost) {
      setState(() {
        currentUser.poin -= voucher.cost;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil redeem: ${voucher.title}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Poin tidak cukup!')),
      );
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
            title: Text(voucher.title),
            subtitle: Text("Harga: ${voucher.cost} poin"),
            trailing: ElevatedButton(
              onPressed: () => redeemVoucher(voucher),
              child: const Text("Redeem"),
            ),
          );
        },
      ),
    );
  }
}
