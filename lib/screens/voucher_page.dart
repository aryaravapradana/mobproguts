import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/models/voucher.dart';
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

class _VoucherPageState extends State<VoucherPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vouchers', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.lightGrey,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'My Vouchers'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVoucherList(dummyVouchers, true),
          _buildVoucherList(redeemedVouchers, false),
        ],
      ),
    );
  }

  Widget _buildVoucherList(List<Voucher> vouchers, bool canRedeem) {
    if (vouchers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 60, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              canRedeem ? "No Vouchers Available" : "You haven't redeemed any vouchers yet.",
              style: GoogleFonts.poppins(fontSize: 16, color: AppColors.onSurface),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return _buildVoucherCard(voucher, canRedeem, index);
      },
    );
  }

  Widget _buildVoucherCard(Voucher voucher, bool canRedeem, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VoucherDetailPage(voucher: voucher, user: widget.user),
            ),
          );

          if (result == true) {
            setState(() {});
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.local_activity, color: AppColors.primary, size: 30),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      canRedeem ? "Cost: ${voucher.cost} points" : "Redeemed",
                      style: GoogleFonts.poppins(
                        color: canRedeem ? AppColors.primary : AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.onSurface),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, delay: (100 * index).ms);
  }
}
