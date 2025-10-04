import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RedemptionSuccessScreen extends StatelessWidget {
  final String voucherTitle;
  final int pointsSpent;
  final int remainingPoints;
  final DateTime redemptionDate;

  const RedemptionSuccessScreen({
    super.key,
    required this.voucherTitle,
    required this.pointsSpent,
    required this.remainingPoints,
    required this.redemptionDate,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime localRedemptionDate = redemptionDate;
    final Duration localOffset = localRedemptionDate.timeZoneOffset;
    const Duration gmt7Offset = Duration(hours: 7);
    final Duration adjustment = gmt7Offset - localOffset;
    final DateTime adjustedRedemptionTime = localRedemptionDate.add(adjustment);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, AppColors.primary.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 100,
                ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 30),
                Text(
                  "Redemption Successful!",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  "You have successfully redeemed your voucher.",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Card(
                  color: AppColors.surface.withOpacity(0.9),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Voucher", voucherTitle),
                        _buildDetailRow("Points Spent", "$pointsSpent points"),
                        _buildDetailRow("Remaining Points", "$remainingPoints points"),
                        _buildDetailRow("Date", "${adjustedRedemptionTime.day}/${adjustedRedemptionTime.month}/${adjustedRedemptionTime.year}"),
                        _buildDetailRow("Time (GMT+7)", "${adjustedRedemptionTime.hour.toString().padLeft(2, '0')}:${adjustedRedemptionTime.minute.toString().padLeft(2, '0')}:${adjustedRedemptionTime.second.toString().padLeft(2, '0')}"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst); // Go back to home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Back to Home",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to start for multi-line text
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.lightGrey,
            ),
          ),
          const SizedBox(width: 10), // Add some space between label and value
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.right, // Align value to the right
              softWrap: true, // Allow text to wrap to the next line
            ),
          ),
        ],
      ),
    );
  }
}
