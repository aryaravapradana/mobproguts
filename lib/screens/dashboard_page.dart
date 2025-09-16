import 'package:flutter/material.dart';
import 'voucher_page.dart';
import 'poin_page.dart';
import 'member_page.dart';
import 'saldo_page.dart';
import 'transaksi_page.dart';
import 'payment_page.dart';
import '../auth/login_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {'title': 'Info Poin', 'page': const PoinPage()},
      {'title': 'Info Voucher', 'page': const VoucherPage()},
      {'title': 'Info Member', 'page': const MemberPage()},
      {'title': 'Saldo', 'page': const SaldoPage()},
      {'title': 'Riwayat Transaksi', 'page': const TransaksiPage()},
      {'title': 'Payment', 'page': const PaymentPage()},
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
