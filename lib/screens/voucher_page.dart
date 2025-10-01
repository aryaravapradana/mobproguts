import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/voucher_data.dart';
import '../models/user.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';

class VoucherPage extends StatefulWidget {
  final UserModel user;
  const VoucherPage({super.key, required this.user});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Vouchers', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: dummyVouchers.length,
        itemBuilder: (context, index) {
          final voucher = dummyVouchers[index];
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.gold,
                child: Icon(Icons.local_offer, color: AppColors.black),
              ),
              title: Text(
                voucher.title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              subtitle: Text(
                "${voucher.cost} poin",
                style: GoogleFonts.poppins(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VoucherDetailPage(voucher: voucher, user: widget.user),
                  ),
                );
              },
            ),
          ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0, delay: (100 * index).ms);
        },
      ),
    );
  }
}
