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
    final MembershipTier currentTier = tiers.firstWhere((t) => t.name == level, orElse: () => tiers.first);
    final int currentTierIndex = tiers.indexOf(currentTier);
    MembershipTier? nextTier;
    double progress = 0;

    if (currentTierIndex < tiers.length - 1) {
      nextTier = tiers[currentTierIndex + 1];
      double xpForNextTier = (nextTier.minXp - currentTier.minXp).toDouble();
      double xpInCurrentTier = xp - currentTier.minXp;
      progress = (xpForNextTier > 0) ? (xpInCurrentTier / xpForNextTier) : 1.0;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withAlpha(51),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
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
                  fontSize: 16,
                ),
              ),
              Row(
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
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            points.toString(),
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (nextTier != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                valueColor: AlwaysStoppedAnimation<Color>(currentTier.color),
                backgroundColor: AppColors.darkGrey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${(progress * 100).toStringAsFixed(0)}% to ${nextTier.name}",
              style: GoogleFonts.poppins(
                color: AppColors.onSurface,
              ),
            ),
          ],
        ],
      ),
    ).animate().fade(duration: 500.ms).scale(delay: 200.ms);
  }
}
