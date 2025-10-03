import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/helpers/tier_style.dart';
import 'package:project_midterms/screens/tier_info_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/user.dart';
import '../models/membership_tier.dart';

class MembershipDetailPage extends StatefulWidget {
  final UserModel user;
  const MembershipDetailPage({super.key, required this.user});

  @override
  State<MembershipDetailPage> createState() => _MembershipDetailPageState();
}

class _MembershipDetailPageState extends State<MembershipDetailPage> {
  late double _currentUserXp;
  late MembershipTier _currentTier;
  MembershipTier? _nextTier;
  double _progress = 0.0;
  double _xpNeeded = 0.0;

  @override
  void initState() {
    super.initState();
    _currentUserXp = widget.user.xp;
    _calculateTierProgress();
  }

  void _calculateTierProgress() {
    _currentTier = tiers.lastWhere((tier) => _currentUserXp >= tier.minXp, orElse: () => tiers.first);
    int currentTierIndex = tiers.indexOf(_currentTier);

    if (currentTierIndex < tiers.length - 1) {
      _nextTier = tiers[currentTierIndex + 1];
      double xpForNextTier = (_nextTier!.minXp - _currentTier.minXp).toDouble();
      double xpInCurrentTier = _currentUserXp - _currentTier.minXp;
      _progress = (xpForNextTier > 0) ? (xpInCurrentTier / xpForNextTier) : 1.0;
      _xpNeeded = _nextTier!.minXp - _currentUserXp;
    } else {
      _nextTier = null;
      _progress = 1.0;
      _xpNeeded = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildTierCards(),
            const SizedBox(height: 24),
            _buildTermsSection(),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: getGradientForTier(_currentTier.name),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FaIcon(getFaIconForTier(_currentTier.name), color: getTextColorForTier(_currentTier.name), size: 50),
              const SizedBox(height: 12),
              Text(
                _currentTier.name,
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: getTextColorForTier(_currentTier.name)),
              ),
              const SizedBox(height: 4),
              Text(
                'Total XP: ${_currentUserXp.toStringAsFixed(1)} XP',
                style: GoogleFonts.poppins(color: getTextColorForTier(_currentTier.name).withOpacity(0.8), fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final textColor = getTextColorForTier(_currentTier.name);
    final glowColor = getGlowColorForTier(_currentTier.name);
    final isHighestTier = _nextTier == null;

    return Column(
      children: [
        if (!isHighestTier)
          Text(
            'Add ${_xpNeeded.toStringAsFixed(1)} more XP to reach ${_nextTier!.name}',
            style: GoogleFonts.poppins(color: textColor.withOpacity(0.9), fontWeight: FontWeight.w600),
          )
        else
          Text(
            'You have reached the highest tier!',
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final double barWidth = constraints.maxWidth;
            final double indicatorDiameter = 28; // Made bigger
            // Calculate position, ensuring it doesn't go out of bounds
            final double indicatorPosition = (barWidth * _progress).clamp(indicatorDiameter / 2, barWidth - indicatorDiameter / 2) - (indicatorDiameter / 2);

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                // The progress bar background
                Container(
                  height: 14,
                  width: barWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.2),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                ),
                // The progress bar value
                Container(
                  height: 14,
                  width: barWidth * _progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isHighestTier ? glowColor : Colors.white.withOpacity(0.8),
                  ),
                ),
                // The glowing indicator
                Positioned(
                  left: indicatorPosition,
                  child: Container(
                    height: indicatorDiameter,
                    width: indicatorDiameter,
                    alignment: Alignment.center, // Centered the icon
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: glowColor,
                      border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: glowColor.withOpacity(0.9),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: FaIcon(isHighestTier ? FontAwesomeIcons.gem : FontAwesomeIcons.star, color: Colors.white, size: 14), // Made icon bigger
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                   .scale(duration: 1500.ms, end: const Offset(1.2, 1.2), curve: Curves.easeOut)
                   .then(delay: 200.ms)
                   .scale(duration: 1500.ms, end: const Offset(1, 1), curve: Curves.easeIn),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTierCards() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tiers.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final tier = tiers[index];
          bool isCurrent = tier.name == _currentTier.name;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TierInfoPage(tier: tier)),
              );
            },
            child: _TierCard(tier: tier, isCurrent: isCurrent),
          );
        },
      ),
    );
  }

  Widget _buildTermsSection() {
    return Card(
      child: ListTile(
        title: Text('Terms & Conditions', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: const Text('Learn about XP calculation and tier changes.'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showTermsAndConditions(context),
      ),
    );
  }

  void _showTermsAndConditions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terms & Conditions', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text(
                      '1. XP is calculated from your total spending over the last 3 months.\n\n' 
                      '2. Every purchase of IDR 1,000 will earn you 1 Voucher Point and 0.1 XP. Points are for redeeming vouchers, while XP is for leveling up your tier.\n\n' 
                      '3. Tier upgrades happen automatically when your XP reaches the minimum threshold for the next tier.\n\n' 
                      '4. Tier downgrades are evaluated every 3 months. If your total XP does not meet the minimum requirement for your current tier, your tier will be adjusted accordingly.\n\n' 
                      '5. Remember what Timothy Ronald said, "People who are constantly frugal cannot be that smart, because it is the most IDIOTIC activity, yes the most IDIOTIC because you can\'t take money to the grave, especially this fictitious money, so keep shopping.'
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TierCard extends StatelessWidget {
  final MembershipTier tier;
  final bool isCurrent;

  const _TierCard({required this.tier, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.decimalPattern('id');
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent ? tier.color.withAlpha(51) : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCurrent ? tier.color : AppColors.darkGrey,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tier.icon, color: tier.color, size: 30),
            const SizedBox(height: 8),
            Text(tier.name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('${f.format(tier.minXp)} XP', style: TextStyle(fontSize: 12, color: AppColors.onSurface.withAlpha(179))),
          ],
        ),
      ),
    );
  }
}

IconData getFaIconForTier(String level) {
  switch (level) {
    case 'Bronze':
      return FontAwesomeIcons.shieldHalved;
    case 'Silver':
      return FontAwesomeIcons.starHalfAlt;
    case 'Gold':
      return FontAwesomeIcons.star;
    case 'Platinum':
      return FontAwesomeIcons.solidCheckCircle;
    case 'Diamond':
      return FontAwesomeIcons.gem;
    default:
      return FontAwesomeIcons.questionCircle;
  }
}