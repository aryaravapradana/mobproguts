import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';

class PointsCard extends StatelessWidget {
  final int points;
  final double redeemableValue;
  final int untilPlatinum;
  final double progress;

  const PointsCard({
    super.key,
    required this.points,
    required this.redeemableValue,
    required this.untilPlatinum,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // ✅ pakai withValues
            blurRadius: 6,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available Points",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            points.toString(),
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$$redeemableValue in Redeemable Value",
            style: TextStyle(color: AppColors.white.withAlpha(178)),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            color: AppColors.gold,
            backgroundColor: AppColors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 6),
          Text(
            "$untilPlatinum until Platinum",
            style: TextStyle(color: AppColors.white.withAlpha(178)),
          ),
        ],
      ),
    );
  }
}