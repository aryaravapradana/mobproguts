import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:project_midterms/screens/redeemed_voucher_detail_page.dart';

class MyVouchersPage extends StatelessWidget {
  const MyVouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Vouchers',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildVoucherList(context, redeemedVouchers),
    );
  }

  Widget _buildVoucherList(BuildContext context, List<Voucher> vouchers) {
    if (vouchers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 60, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              "You haven't redeemed any vouchers yet.",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    vouchers.sort((a, b) {
      final aDate =
          a.expiryDate ?? DateTime.now().add(const Duration(days: 999));
      final bDate =
          b.expiryDate ?? DateTime.now().add(const Duration(days: 999));
      return aDate.compareTo(bDate);
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RedeemedVoucherDetailPage(voucher: voucher),
              ),
            );
          },
          child: _buildVoucherCard(
            voucher,
          ).animate().fadeIn(duration: 300.ms, delay: (50 * index).ms),
        );
      },
    );
  }

  Widget _buildVoucherCard(Voucher voucher) {
    final now = DateTime.now();
    final expiryDate = voucher.expiryDate;
    String expiryText = 'No expiry date';
    Color expiryColor = AppColors.onSurface.withAlpha(153);
    bool isExpired = false;

    if (expiryDate != null) {
      final daysLeft = expiryDate.difference(now).inDays;
      if (now.isAfter(expiryDate)) {
        isExpired = true;
        expiryText =
            'Expired on ${DateFormat('d MMM yyyy').format(expiryDate)}';
        expiryColor = AppColors.error;
      } else if (daysLeft < 7) {
        expiryText = 'Expires in $daysLeft day(s)';
        expiryColor = Colors.orange.shade700;
      } else {
        expiryText =
            'Expires on ${DateFormat('d MMM yyyy').format(expiryDate)}';
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isExpired ? AppColors.darkGrey.withAlpha(100) : AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                voucher.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
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
                      color: isExpired
                          ? AppColors.onSurface.withAlpha(100)
                          : AppColors.onSurface,
                      decoration: isExpired
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: expiryColor),
                      const SizedBox(width: 6),
                      Text(
                        expiryText,
                        style: GoogleFonts.poppins(
                          color: expiryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'klik, untuk melihat informasi lebih lanjut',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.lightGrey,
                      fontStyle: FontStyle.italic,
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
