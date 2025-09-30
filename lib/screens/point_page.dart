import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/screens/voucher_page.dart'; // New import
import 'package:project_midterms/screens/transaksi_page.dart'; // New import
import 'package:intl/intl.dart';

class PointPage extends StatelessWidget {
  final UserModel user;
  const PointPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(
          "My Points",
          style: GoogleFonts.poppins(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withAlpha(51),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Points",
                    style: GoogleFonts.poppins(
                      color: AppColors.white.withAlpha(204),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${user.poin}",
                    style: GoogleFonts.poppins(
                      color: AppColors.gold,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You have ${user.poin} points available.",
                    style: GoogleFonts.poppins(
                      color: AppColors.white.withAlpha(179),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Quick Actions
            Text(
              "Quick Actions",
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context,
                  Icons.card_giftcard,
                  "Tukarkan Voucher",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VoucherPage(user: user)),
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  Icons.history,
                  "Riwayat Transaksi",
                  () {
                    Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => TransaksiPage()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Point Earning Tips
            Text(
              "How to Earn More Points",
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildEarningTip(
              Icons.shopping_cart,
              "Shop & Earn",
              "Get 1 point for every ${NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0).format(10)} spent.",
            ),
            _buildEarningTip(
              Icons.person_add,
              "Refer a Friend",
              "Earn 50 points for every successful referral.",
            ),
            _buildEarningTip(
              Icons.event,
              "Participate in Events",
              "Join our events and get bonus points.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.gold.withAlpha(51),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.gold, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningTip(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.gold, size: 25),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: AppColors.white.withAlpha(179),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}