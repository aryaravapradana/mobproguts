import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/models/membership_tier.dart';

class PointsCard extends StatelessWidget {
  final int points;
  final String level;
  final double xp;

  const PointsCard({
    super.key,
    required this.points,
    required this.level,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    final MembershipTier currentTier = tiers.firstWhere(
      (t) => t.name == level,
      orElse: () => tiers.first,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Points Balance",
                style: GoogleFonts.poppins(
                  color: AppColors.onSurface,
                  fontSize: 18,
                ),
              ),
              // --- Chip Level yang lebih stylish ---
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                                    color: currentTier.color.withAlpha((255 * 0.15).round()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(currentTier.icon, color: currentTier.color, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      level,
                      style: GoogleFonts.poppins(
                        color: currentTier.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            points.toString(),
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: 52,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}
