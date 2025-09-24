import 'package:flutter/material.dart';
import 'package:project_midterms/auth/login_page.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/member_page.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/settings_page.dart';
import '../colors.dart';

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
        title: const Text('Akun'),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFF2C2C2E),
                            child: Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                widget.user.email,
                                style: TextStyle(
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
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildListTile(
              Icons.person,
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
              Icons.settings,
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
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppColors.white.withAlpha(153)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.white)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.white.withAlpha(153)))
            : null,
        trailing: Icon(Icons.chevron_right, color: AppColors.white.withAlpha(153)),
        onTap: onTap,
      ),
    );
  }
}
