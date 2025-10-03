import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/mission_data.dart';
import 'package:project_midterms/models/mission.dart';
import 'package:project_midterms/models/user.dart';

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
    // Create a mutable copy of the missions
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
      case 'Bronze':
      default:
        return 1.0;
    }
  }

  void _claimReward(Mission mission) {
    final multiplier = _getTierMultiplier();
    final reward = (mission.basePointReward * multiplier).round();

    setState(() {
      widget.user.poin += reward;
      // Find the mission in the list and replace it with a claimed version
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missions', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: missions.length,
        itemBuilder: (context, index) {
          final mission = missions[index];
          return _MissionCard(
            mission: mission,
            tierMultiplier: _getTierMultiplier(),
            onClaim: () => _claimReward(mission),
          );
        },
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final Mission mission;
  final double tierMultiplier;
  final VoidCallback onClaim;

  const _MissionCard({
    required this.mission,
    required this.tierMultiplier,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = (mission.progress / mission.target).clamp(0.0, 1.0);
    final reward = (mission.basePointReward * tierMultiplier).round();
    final canClaim = mission.isCompleted && !mission.isClaimed;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(mission.icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    mission.title,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(mission.description, style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(180))),
            const SizedBox(height: 16),
            // Progress Bar and Text
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 10,
                      backgroundColor: AppColors.darkGrey,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${mission.progress.round()}/${mission.target.round()}',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Reward and Claim Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("REWARD", style: GoogleFonts.poppins(fontSize: 10, color: AppColors.lightGrey)),
                    Text(
                      '$reward Points',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: canClaim ? onClaim : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mission.isClaimed ? AppColors.darkGrey : AppColors.success,
                  ),
                  child: Text(mission.isClaimed ? 'Claimed' : (mission.isCompleted ? 'Claim' : 'In Progress')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
