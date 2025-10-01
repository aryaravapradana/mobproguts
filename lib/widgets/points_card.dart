import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PointsCard extends StatelessWidget {
  final int points;
  final double redeemableValue;
  final String nextLevel;
  final double progress;

  const PointsCard({
    super.key,
    required this.points,
    required this.redeemableValue,
    required this.nextLevel,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColors.gold.withAlpha(204), AppColors.gold.withAlpha(128)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withAlpha(77),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Points",
            style: GoogleFonts.poppins(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            points.toString(),
            style: GoogleFonts.poppins(
              color: AppColors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$${redeemableValue.toStringAsFixed(2)} in Redeemable Value",
            style: GoogleFonts.poppins(
              color: AppColors.white.withAlpha(204),
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
              backgroundColor: AppColors.white.withAlpha(77),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${(progress * 100).toStringAsFixed(0)}% to $nextLevel",
            style: GoogleFonts.poppins(
              color: AppColors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).scale(delay: 200.ms);
  }
}