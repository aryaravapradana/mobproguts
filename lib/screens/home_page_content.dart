import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/missions_page.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import 'package:project_midterms/widgets/daily_reward_card.dart';
import '../widgets/points_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageContent extends StatefulWidget {
  final UserModel user;
  const HomePageContent({super.key, required this.user});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  void _onRewardClaimed() {
    setState(() {
      // This will force the widget to rebuild and show the updated points
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey, ${widget.user.name}!", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
                  MaterialPageRoute(builder: (context) => MembershipDetailPage(user: widget.user)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PointsCard(
                  points: widget.user.poin,
                  level: widget.user.level,
                  xp: widget.user.xp,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DailyRewardCard(
                user: widget.user,
                onClaim: _onRewardClaimed,
              ),
            ),
            const SizedBox(height: 16),
            _buildMissionsCard(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, title: "Explore Vouchers", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherPage(user: widget.user)));
            }),
            const SizedBox(height: 16),
            _buildPromoBanner(),
            const SizedBox(height: 24),
            _buildSectionHeader(context, title: "Hot Vouchers"),
            const SizedBox(height: 16),
            _buildVoucherCarousel(context, widget.user),
            const SizedBox(height: 24),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildMissionsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissionsPage(user: widget.user)),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.flag, color: AppColors.accent, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Missions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text("Complete tasks and earn more points!", style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(180))),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: AppColors.lightGrey),
              ],
            ),
          ),
        ),
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
    final promos = [
      {
        "title": "Diskon 10% di Coffee Shop",
        "subtitle": "Hanya butuh 500 poin buat klaim sekarang!",
        "bg": Colors.orange
      },
      {
        "title": "Voucher Rp50.000",
        "subtitle": "Tukar 1000 poin, langsung hemat belanja!",
        "bg": Colors.blue
      },
      {
        "title": "Free Parking 2 Jam",
        "subtitle": "Parkir santai cukup 700 poin aja",
        "bg": Colors.green
      },
    ];

    return CarouselSlider.builder(
      itemCount: promos.length,
      itemBuilder: (context, index, realIndex) {
        final promo = promos[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: promo["bg"] as Color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                promo["title"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                promo["subtitle"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        autoPlayInterval: const Duration(seconds: 4),
      ),
    );
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
