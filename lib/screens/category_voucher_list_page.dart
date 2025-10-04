import 'package:flutter/material.dart';
import 'package:project_midterms/models/voucher.dart';

class CategoryVoucherListPage extends StatelessWidget {
  final String category;
  final List<Voucher> vouchers;

  const CategoryVoucherListPage({super.key, required this.category, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return ListTile(
            title: Text(voucher.title),
            subtitle: Text(voucher.description ?? ''),
            trailing: Text('${voucher.cost} points'),
          );
        },
      ),
    );
  }
}
