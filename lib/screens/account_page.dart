import 'package:flutter/material.dart';
import 'package:project_midterms/auth/login_page.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/member_page.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/settings_page.dart';
import 'package:project_midterms/screens/redeem_history_page.dart';
import 'package:project_midterms/screens/point_page.dart';
import '../colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/helpers/tier_style.dart';

class AccountPage extends StatefulWidget {
  final UserModel user;
  const AccountPage({super.key, required this.user});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuList(),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MembershipDetailPage(user: widget.user)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: getGradientForTier(widget.user.level),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                            color: getGlowColorForTier(widget.user.level).withAlpha((255 * 0.5).round()),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                                backgroundColor: Colors.white.withAlpha((255 * 0.2).round()),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.level,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: getTextColorForTier(widget.user.level),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    return Card(
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.badge,
            title: 'Info Member',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberPage(user: widget.user)),
              );
            },
          ),
          _buildListTile(
            icon: Icons.star,
            title: 'My Points',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PointPage(user: widget.user)),
              );
            },
          ),
          _buildListTile(
            icon: Icons.receipt,
            title: 'Riwayat Redeem',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RedeemHistoryPage()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.settings,
            title: 'Pengaturan Akun',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(user: widget.user)),
              );
            },
          ),
          _buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: _logout,
            hasTrailing: false,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasTrailing = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.onSurface)),
      trailing: hasTrailing ? const Icon(Icons.chevron_right, color: AppColors.onSurface) : null,
      onTap: onTap,
    );
  }
}
