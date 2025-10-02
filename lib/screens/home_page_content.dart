import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import '../widgets/points_card.dart'; // I will redesign this widget later
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';

class HomePageContent extends StatelessWidget {
  final UserModel user;
  const HomePageContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey, ${user.name}!", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembershipDetailPage(user: user)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PointsCard(
                  points: user.poin,
                  level: user.level,
                  xp: user.xp,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, title: "Explore Vouchers", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherPage(user: user)));
            }),
            const SizedBox(height: 16),
            _buildPromoBanner(),
            const SizedBox(height: 24),
            _buildSectionHeader(context, title: "Hot Vouchers"),
            const SizedBox(height: 16),
            _buildVoucherCarousel(context, user),
            const SizedBox(height: 24),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.onBackground),
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: const Text("View All", style: TextStyle(color: AppColors.primary)),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withAlpha(179)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/img/promo_bg.png'), // Placeholder
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Special Offer For You!",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            "Get 20% off on your next purchase. Claim your voucher now!",
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.onPrimary.withAlpha(230)),
          ),
        ],
      ),
    ).animate().scaleXY(delay: 200.ms, duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildVoucherCarousel(BuildContext context, UserModel user) {
    final vouchers = dummyVouchers.take(2).toList();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vouchers.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoucherDetailPage(voucher: voucher, user: user),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Container(
                        height: 100,
                        width: 180,
                        color: AppColors.darkGrey,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: AppColors.lightGrey,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            voucher.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${voucher.cost} points",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
