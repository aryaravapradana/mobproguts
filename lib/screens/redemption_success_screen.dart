import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/models/voucher.dart';

class RedemptionSuccessScreen extends StatelessWidget {
  final Voucher voucher;
  final UserModel user;
  final DateTime redemptionDate;

  const RedemptionSuccessScreen({
    super.key,
    required this.voucher,
    required this.user,
    required this.redemptionDate,
  });

  @override
  Widget build(BuildContext context) {
    final gmtPlus7Time = redemptionDate.toUtc().add(const Duration(hours: 7));
    final formattedDate = DateFormat('d MMMM yyyy, HH:mm').format(gmtPlus7Time);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Redemption Successful', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 80),
              const SizedBox(height: 24),
              Text(
                'Congratulations!',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'You have successfully redeemed the voucher.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16, color: AppColors.onSurface),
              ),
              const SizedBox(height: 40),
              _buildTicket(context, formattedDate),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Back to Home', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.onPrimary, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicket(BuildContext context, String formattedDate) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'VOUCHER REDEEMED',
                  style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5),
                ),
                const SizedBox(height: 16),
                Image.asset(voucher.image, height: 100, fit: BoxFit.cover),
                const SizedBox(height: 16),
                Text(
                  voucher.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
              ],
            ),
          ),
          _buildDashedDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildInfoRow('Price (Sebelum Diskon):', '${voucher.cost} Points'),
                const SizedBox(height: 12),
                _buildInfoRow('Remaining Points:', '${user.poin} Points'),
                const SizedBox(height: 12),
                _buildInfoRow('Date:', '$formattedDate (GMT+7)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: List.generate(30, (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : AppColors.darkGrey,
            height: 2,
          ),
        )),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.lightGrey)),
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      ],
    );
  }
}