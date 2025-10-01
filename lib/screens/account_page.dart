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
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Account', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembershipDetailPage(user: widget.user)),
                );
              },
              child: Card(
                color: const Color(0xFF1E1E1E),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: AppColors.gold,
                        child: Icon(
                          Icons.person,
                          color: AppColors.black,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.white.withAlpha(153),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right, color: AppColors.white.withAlpha(153)),
                    ],
                  ),
                ),
              ),
            ).animate().fade(duration: 500.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(height: 20),
            ...[
              buildListTile(
                Icons.person_outline,
                'Info Member',
                'Lihat info member anda',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemberPage(user: widget.user)),
                  );
                },
              ),
              buildListTile(
                Icons.star_outline,
                'My Points',
                'Lihat poin anda',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointPage(user: widget.user)),
                  );
                },
              ),
              buildListTile(
                Icons.receipt_long_outlined,
                'Riwayat Redeem',
                'Lihat riwayat redeem voucher anda',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RedeemHistoryPage()),
                  );
                },
              ),
              buildListTile(
                Icons.settings_outlined,
                'Pengaturan Akun',
                'Ganti Password, Ganti PIN & Daftar Alamat',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage(user: widget.user)),
                  );
                },
              ),
              buildListTile(Icons.logout, 'Logout', '', _logout),
            ].map((widget) => Animate(
              effects: [FadeEffect(duration: 500.ms), SlideEffect(begin: const Offset(0, 0.2), end: Offset.zero)],
              child: widget,
            )),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.gold),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.white)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.white.withAlpha(153)))
            : null,
        trailing: Icon(Icons.chevron_right, color: AppColors.white.withAlpha(153)),
        onTap: onTap,
      ),
    );
  }
}
