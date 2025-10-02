import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVouchersPage extends StatelessWidget {
  const MyVouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vouchers', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: _buildVoucherList(redeemedVouchers),
    );
  }

  Widget _buildVoucherList(List<Voucher> vouchers) {
    if (vouchers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 60, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              "You haven't redeemed any vouchers yet.",
              style: GoogleFonts.poppins(fontSize: 16, color: AppColors.onSurface),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return _buildVoucherCard(voucher);
      },
    );
  }

  Widget _buildVoucherCard(Voucher voucher) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.local_activity, color: AppColors.primary, size: 30),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Redeemed",
                    style: GoogleFonts.poppins(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
