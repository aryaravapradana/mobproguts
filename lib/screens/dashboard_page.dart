import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import 'package:project_midterms/screens/member_page.dart';
import 'package:project_midterms/screens/transaksi_page.dart';
import 'package:project_midterms/screens/payment_page.dart';
import 'package:project_midterms/screens/account_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;
  const DashboardPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {'title': 'Info Voucher', 'page': VoucherPage(user: user), 'icon': Icons.local_offer},
      {'title': 'Info Member', 'page': MemberPage(user: user), 'icon': Icons.person},
      {'title': 'Riwayat Transaksi', 'page': const TransaksiPage(), 'icon': Icons.history},
      {'title': 'Payment', 'page': PaymentPage(user: user), 'icon': Icons.payment},
      {'title': 'Akun', 'page': AccountPage(user: user), 'icon': Icons.account_circle},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) => Card(
            color: const Color(0xFF1E1E1E),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => menu[index]['page']),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(menu[index]['icon'], size: 40, color: AppColors.gold),
                    const SizedBox(height: 10),
                    Text(
                      menu[index]['title'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0, delay: (100 * index).ms),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 1.5),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}