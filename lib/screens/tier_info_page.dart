import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/membership_tier.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TierInfoPage extends StatelessWidget {
  final MembershipTier tier;

  const TierInfoPage({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tier.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionCard(
              title: 'Description',
              child: Text(
                tier.description,
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.onSurface.withAlpha(204), height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'Benefits',
              child: Column(
                children: tier.perks.map((perk) => ListTile(
                  leading: Icon(perk.icon, color: AppColors.primary),
                  title: Text(perk.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.zero,
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'How to Achieve',
              child: Text(
                'You need to earn a minimum of ${tier.minXp} XP.',
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.onSurface.withAlpha(204), height: 1.5),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Icon(tier.icon, color: tier.color, size: 80),
          const SizedBox(height: 16),
          Text(
            tier.name,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: tier.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.onBackground),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
