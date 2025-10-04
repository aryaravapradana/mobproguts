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
          if (points == -1) // Special case for hidden points
            Column( // Use Column to stack the hidden points and the click text
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( // Hidden points with icon
                  children: [
                    Icon(Icons.visibility_off, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "••••", // Placeholder for hidden points
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Small space between points and text
                Text(
                  "klik untuk melihat total poin yang kamu miliki",
                  style: GoogleFonts.poppins(
                    color: AppColors.onSurface.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
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
