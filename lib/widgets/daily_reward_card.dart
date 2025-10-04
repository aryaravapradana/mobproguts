import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/widgets/animated_hover_card.dart';

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
  bool _hasBeenClaimedThisSession = false;
  final int _rewardAmount = 25;

  void _claimReward() {
    if (_hasBeenClaimedThisSession) return;

    setState(() {
      widget.user.poin += _rewardAmount;
      _hasBeenClaimedThisSession = true;
      widget.onClaim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canClaim = !_hasBeenClaimedThisSession;

    return AnimatedHoverCard(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: const Icon(Icons.card_giftcard_outlined, color: AppColors.primary, size: 40),
        title: Text(
          'Daily Reward',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          canClaim ? 'Claim your points!' : 'Already claimed',
          style: GoogleFonts.poppins(
            color: AppColors.onSurface.withAlpha(180),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _ClaimButton(canClaim: canClaim, onTap: _claimReward, rewardAmount: _rewardAmount),
      ),
    );
  }
}

class _ClaimButton extends StatefulWidget {
  final bool canClaim;
  final VoidCallback onTap;
  final int rewardAmount;

  const _ClaimButton({required this.canClaim, required this.onTap, required this.rewardAmount});

  @override
  State<_ClaimButton> createState() => _ClaimButtonState();
}

class _ClaimButtonState extends State<_ClaimButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!widget.canClaim) return;
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        if (!widget.canClaim) return;
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        if (!widget.canClaim) return;
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.canClaim ? AppColors.primary : AppColors.darkGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed && widget.canClaim
              ? [
                  BoxShadow(
                                        color: AppColors.primary.withAlpha((255 * 0.7).round()),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Text(
          widget.canClaim ? 'Claim' : 'Done',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: widget.canClaim ? AppColors.onPrimary : AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
