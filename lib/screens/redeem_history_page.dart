import 'package:flutter/material.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class RedeemHistoryPage extends StatelessWidget {
  const RedeemHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redeem History', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: redeemedVouchers.isEmpty
          ? _buildEmptyState()
          : _buildHistoryList(),
    );
  }

  Widget _buildEmptyState() {
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
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: redeemedVouchers.length,
      itemBuilder: (context, index) {
        final voucher = redeemedVouchers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    voucher.image,
                    width: 40,
                    height: 40,
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
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      if (voucher.redemptionDate != null)
                        Text(
                          "Redeemed on ${DateFormat('d MMM yyyy').format(voucher.redemptionDate!)}",
                          style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(179), fontSize: 12),
                        ),
                    ],
                  ),
                ),
                Text(
                  "-${voucher.cost} Poin",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.error),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 300.ms, delay: (50 * index).ms);
      },
    );
  }
}
