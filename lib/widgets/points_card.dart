import 'package:flutter/material.dart';

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
        color: const Color(0xFF5a6e64),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), // ✅ pakai withValues
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
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            points.toString(),
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$$redeemableValue in Redeemable Value",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            color: Colors.orange,
            backgroundColor: Colors.white24,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 6),
          Text(
            "$untilPlatinum until Platinum",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
