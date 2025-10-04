// MissionCard.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/mission.dart';

class MissionCard extends StatelessWidget {
  final Mission mission;
  final double tierMultiplier;
  final VoidCallback onClaim;

  const MissionCard({
    super.key,
    required this.mission,
    required this.tierMultiplier,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = (mission.progress / mission.target).clamp(0.0, 1.0);
    final reward = (mission.basePointReward * tierMultiplier).round();
    final canClaim = mission.isCompleted && !mission.isClaimed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(mission.icon, color: AppColors.primary, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mission.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reward: $reward Points', // Info reward
                      style: GoogleFonts.poppins(
                        color: AppColors.onSurface.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // --- Tombol Claim  ---
              _buildClaimButton(canClaim),
            ],
          ),
          const SizedBox(height: 16),
          // --- Progress Bar ---
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 6, // Lebih tipis
                    backgroundColor: AppColors.darkGrey,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${mission.progress.round()}/${mission.target.round()}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimButton(bool canClaim) {
    if (mission.isClaimed) {
      return const Icon(Icons.check_circle, color: AppColors.success, size: 28);
    }

    if (canClaim) {
      return ElevatedButton(
        onPressed: onClaim,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text('Claim'),
      );
    }

    return const SizedBox.shrink();
  }
}
