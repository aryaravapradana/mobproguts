import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/mission_data.dart';
import 'package:project_midterms/models/mission.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/widgets/animated_hover_card.dart';
import 'package:project_midterms/widgets/mission_card.dart'; // Re-added this import

import 'package:flutter_animate/flutter_animate.dart';

class MissionsPage extends StatefulWidget {
  final UserModel user;
  const MissionsPage({super.key, required this.user});

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  late List<Mission> missions;

  @override
  void initState() {
    super.initState();
    missions = List<Mission>.from(dummyMissions);
  }

  double _getTierMultiplier() {
    switch (widget.user.level) {
      case 'Silver':
        return 1.2;
      case 'Gold':
        return 1.5;
      case 'Platinum':
        return 1.8;
      case 'Diamond':
        return 2.0;
      default:
        return 1.0;
    }
  }

  void _claimReward(Mission mission) {
    final multiplier = _getTierMultiplier();
    final reward = (mission.basePointReward * multiplier).round();

    setState(() {
      widget.user.poin += reward;
      final index = missions.indexWhere((m) => m.title == mission.title);
      if (index != -1) {
        missions[index] = Mission(
          title: mission.title,
          description: mission.description,
          icon: mission.icon,
          basePointReward: mission.basePointReward,
          target: mission.target,
          progress: mission.progress,
          isClaimed: true,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You earned $reward points!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Missions',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 120,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      "Explore Ways to Earn!",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.1, delay: 50.ms),
                const SizedBox(height: 16),
                IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildMissionActionCard(
                              context,
                              Icons.shopping_bag_outlined,
                              "Shop & Earn",
                              "Go to Voucher Page",
                            ),
                          ), // Placeholder action
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMissionActionCard(
                              context,
                              Icons.event_outlined,
                              "Events",
                              "No events yet",
                            ),
                          ), // Placeholder action
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMissionActionCard(
                              context,
                              Icons.person_add_alt_1_outlined,
                              "Refer a Friend",
                              "Share your code",
                            ),
                          ), // Placeholder action
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.1, delay: 150.ms),
                const SizedBox(height: 24),
                Text(
                      "Your Missions",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.1, delay: 250.ms),
                const SizedBox(height: 16),
                ...missions.map((mission) {
                  final index = missions.indexOf(mission);
                  return MissionCard(
                    mission: mission,
                    tierMultiplier: _getTierMultiplier(),
                    onClaim: () => _claimReward(mission),
                  ).animate().fadeIn(
                    duration: 300.ms,
                    delay: (300 + 50 * index).ms,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String snackBarMessage,
  ) {
    return AnimatedHoverCard(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackBarMessage),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.accent, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return TweenAnimationBuilder<Alignment>(
      tween: AlignmentTween(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: const Duration(seconds: 20),
      builder: (context, alignment, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.background,
                AppColors.primary.withAlpha(40),
                AppColors.background,
              ],
              begin: alignment,
              end: -alignment,
            ),
          ),
        );
      },
    );
  }
}