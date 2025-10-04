import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/missions_page.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import 'package:project_midterms/widgets/animated_hover_card.dart';
import 'package:project_midterms/widgets/daily_reward_card.dart';
import '../widgets/points_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PromoBanner {
  final String title;
  final String subtitle;
  final String imageUrl;

  PromoBanner({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
// -----------------------------------------

class HomePageContent extends StatefulWidget {
  final UserModel user;
  const HomePageContent({super.key, required this.user});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  void _onRewardClaimed() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hey, ${widget.user.name}!",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AnimatedHoverCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembershipDetailPage(user: widget.user),
                      ),
                    );
                  },
                  child: PointsCard(
                    points: widget.user.poin,
                    level: widget.user.level,
                    xp: widget.user.xp,
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: DailyRewardCard(
                          user: widget.user,
                          onClaim: _onRewardClaimed,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMissionsCard(context)),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                title: "Explore Vouchers",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VoucherPage(user: widget.user),
                    ),
                  );
                },
              ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
              const SizedBox(height: 16),
              _buildPromoBanner().animate().fadeIn(
                duration: 300.ms,
                delay: 400.ms,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                context,
                title: "Hot Vouchers",
              ).animate().fadeIn(duration: 300.ms, delay: 500.ms),
              const SizedBox(height: 16),
              _buildVoucherCarousel(
                context,
                widget.user,
              ).animate().fadeIn(duration: 300.ms, delay: 600.ms),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionsCard(BuildContext context) {
    return AnimatedHoverCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MissionsPage(user: widget.user),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: const Icon(
          Icons.rocket_launch_outlined,
          color: AppColors.accent,
          size: 40,
        ),
        title: Text(
          'Missions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'Earn more points!',
          style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(180)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.lightGrey,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: const Text(
                "View All",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    final promos = [
      PromoBanner(
        title: "Diskon 50% Kopi Pilihan",
        subtitle: "Tukar 800 poin buat ngopi hemat!",
        imageUrl: "assets/images/promo_coffee.png",
      ),
      PromoBanner(
        title: "Voucher Belanja Rp50.000",
        subtitle: "Hanya 1000 poin, belanja jadi lebih irit!",
        imageUrl: "assets/images/promo_fashion.png",
      ),
      PromoBanner(
        title: "Gratis Tiket Nonton",
        subtitle: "Ajak temanmu nonton dengan 1200 poin!",
        imageUrl: "assets/images/promo_movie.png",
      ),
    ];

    return CarouselSlider.builder(
      itemCount: promos.length,
      itemBuilder: (context, index, realIndex) {
        final promo = promos[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  promo.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surface,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.lightGrey,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha((255 * 0.6).round()),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black.withAlpha((255 * 0.5).round()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        promo.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withAlpha((255 * 0.9).round()),
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black.withAlpha((255 * 0.5).round()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.88,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      ),
    );
  }

  Widget _buildVoucherCarousel(BuildContext context, UserModel user) {
    final sortedVouchers = List<Voucher>.from(dummyVouchers);
    sortedVouchers.sort((a, b) => b.cost.compareTo(a.cost));
    final vouchers = sortedVouchers.take(5).toList();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vouchers.length,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ), // Padding di kedua sisi
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Container(
            width: 180,
            margin: EdgeInsets.only(
              right: index == vouchers.length - 1 ? 0 : 16,
            ), // Hilangkan margin di item terakhir
            child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VoucherDetailPage(voucher: voucher, user: user),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: voucher.image != null
                          ? Image.asset(
                              voucher.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: AppColors.lightGrey,
                                      size: 40,
                                    ),
                                  ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: AppColors.lightGrey,
                                size: 40,
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
