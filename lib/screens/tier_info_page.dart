import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/membership_tier.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/helpers/tier_style.dart';

class TierInfoPage extends StatelessWidget {
  final MembershipTier tier;

  const TierInfoPage({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: getGradientForTier(tier.name),
                    boxShadow: [
                      BoxShadow(
                        color: tier.color.withAlpha((255 * 0.4).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(tier.imagePath!, width: 160, height: 160),
                      const SizedBox(height: 4),
                      Text(
                        tier.name,
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        leading: Icon(perk.icon, color: tier.color),
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
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: tier.color.withAlpha((255 * 0.3).round()), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: tier.color),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}