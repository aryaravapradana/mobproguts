import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import 'package:project_midterms/screens/transaksi_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PointPage extends StatelessWidget {
  final UserModel user;
  const PointPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Points", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsDisplay(),
            const SizedBox(height: 32),
            _buildQuickActions(context),
            const SizedBox(height: 32),
            _buildEarningTips(),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildPointsDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withAlpha(179)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
                boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(77), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Points Balance",
            style: GoogleFonts.poppins(color: AppColors.onPrimary.withAlpha(230), fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            user.poin.toString(),
            style: GoogleFonts.poppins(
              color: AppColors.onPrimary,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Actions", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: FontAwesomeIcons.gift,
                label: "Redeem Vouchers",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherPage(user: user))),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                context,
                icon: FontAwesomeIcons.clockRotateLeft,
                label: "History",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransaksiPage())),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            FaIcon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 12),
            Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.onSurface), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("How to Earn More Points", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTipCard(
          icon: FontAwesomeIcons.bagShopping,
          title: "Shop & Earn",
          subtitle: "Get 1 point for every Rp10.000 spent.",
        ),
        _buildTipCard(
          icon: FontAwesomeIcons.userPlus,
          title: "Refer a Friend",
          subtitle: "Earn 50 points for every successful referral.",
        ),
        _buildTipCard(
          icon: FontAwesomeIcons.calendarCheck,
          title: "Participate in Events",
          subtitle: "Join our special events to get bonus points.",
        ),
      ],
    );
  }

  Widget _buildTipCard({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            FaIcon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.onSurface)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(179))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}