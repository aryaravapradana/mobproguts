import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DailyRewardCard extends StatefulWidget {
  final UserModel user;
  final VoidCallback onClaim;

  const DailyRewardCard({
    super.key,
    required this.user,
    required this.onClaim,
  });

  @override
  State<DailyRewardCard> createState() => _DailyRewardCardState();
}

class _DailyRewardCardState extends State<DailyRewardCard> {
  // State is now managed in-memory for the session
  bool _hasBeenClaimedThisSession = false;
  final int _rewardAmount = 25; // Reward 25 points

  void _claimReward() {
    if (_hasBeenClaimedThisSession) return;

    setState(() {
      // Update user points
      widget.user.poin += _rewardAmount;
      // Mark as claimed for this session
      _hasBeenClaimedThisSession = true;
      // Notify parent to rebuild UI
      widget.onClaim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canClaim = !_hasBeenClaimedThisSession;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: canClaim ? _claimReward : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: canClaim
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [AppColors.darkGrey, AppColors.darkGrey.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 40,
              ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.5)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Reward',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      canClaim
                          ? 'Claim your daily $_rewardAmount points!'
                          : 'You have claimed today\'s reward.',
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
              if (canClaim)
                const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
