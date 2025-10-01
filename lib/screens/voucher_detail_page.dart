import 'package:flutter/material.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/screens/payment_page.dart';
import 'package:project_midterms/models/user.dart';

class VoucherDetailPage extends StatelessWidget {
  final Voucher voucher;
  final UserModel user;
  const VoucherDetailPage({super.key, required this.voucher, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Voucher Detail', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [AppColors.gold.withAlpha(204), AppColors.gold.withAlpha(128)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Cost: ${voucher.cost} points",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.black.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fade(duration: 500.ms).scale(delay: 200.ms),
            const SizedBox(height: 24),
            Text(
              "Terms and Conditions",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 12),
            _buildTncItem("Voucher is valid for one-time use only."),
            _buildTncItem("Cannot be combined with other promotions."),
            _buildTncItem("Valid until 31 December 2025."),
            const SizedBox(height: 24),
            Text(
              "How to Use",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 12),
            _buildTncItem("Present this voucher to the cashier upon payment."),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage(user: user)),
          );
        },
        backgroundColor: AppColors.gold,
        icon: const Icon(Icons.payment, color: AppColors.black),
        label: Text(
          "Use Voucher",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0, delay: 400.ms),
    );
  }

  Widget _buildTncItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.gold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(color: AppColors.white.withAlpha(200)),
            ),
          ),
        ],
      ),
    );
  }
}