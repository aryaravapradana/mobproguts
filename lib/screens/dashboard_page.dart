import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'voucher_page.dart';
import 'member_page.dart';
import 'transaksi_page.dart';
import 'payment_page.dart';
import 'account_page.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;
  const DashboardPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {'title': 'Info Voucher', 'page': VoucherPage(user: user)},
      {'title': 'Info Member', 'page': MemberPage(user: user)},
      {'title': 'Riwayat Transaksi', 'page': const TransaksiPage()},
      {'title': 'Payment', 'page': PaymentPage(user: user)},
      {'title': 'Akun', 'page': AccountPage(user: user)},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menu[index]['title']),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => menu[index]['page']),
            ),
          );
        },
      ),
    );
  }
}
