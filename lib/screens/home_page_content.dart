import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:project_midterms/screens/missions_page.dart';
import 'package:project_midterms/screens/my_vouchers_page.dart';
import 'package:project_midterms/screens/settings_page.dart';
import 'package:project_midterms/screens/transaksi_page.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import 'package:project_midterms/widgets/animated_hover_card.dart';
import 'package:project_midterms/widgets/daily_reward_card.dart';
import '../widgets/points_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/data/voucher_data.dart';
import 'package:project_midterms/screens/notification_page.dart';
import 'package:project_midterms/screens/voucher_detail_page.dart';
import 'package:project_midterms/screens/point_page.dart'; 
import 'package:project_midterms/widgets/voucher_cost_display.dart';

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
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
                            PointPage(user: widget.user), 
                      ),
                    );
                  },
                  child: _InteractivePointsDisplay(user: widget.user), 
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
              _buildActionButtons(context).animate().fadeIn(duration: 300.ms, delay: 300.ms),
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
              ).animate().fadeIn(duration: 300.ms, delay: 400.ms),
              const SizedBox(height: 16),
              _buildVoucherCarousel(
                context,
                widget.user,
              ).animate().fadeIn(duration: 300.ms, delay: 500.ms),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(context, Icons.local_activity, "Vouchers", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MyVouchersPage()));
          }),
          _buildActionButton(context, Icons.explore, "Missions", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MissionsPage(user: widget.user)));
          }),
          _buildActionButton(context, Icons.history, "History", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TransaksiPage()));
          }),
          _buildActionButton(context, Icons.settings, "Settings", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage(user: widget.user)));
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.onSurface)),
          ],
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
        ), 
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Container(
            width: 180,
            margin: EdgeInsets.only(
              right: index == vouchers.length - 1 ? 0 : 16,
            ), 
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
                      child: Image.asset(
                        voucher.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.image_not_supported,
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
                          VoucherCostDisplay(voucher: voucher, user: user, fontSize: 12),
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

class _InteractivePointsDisplay extends StatefulWidget {
  final UserModel user;
  const _InteractivePointsDisplay({required this.user});

  @override
  State<_InteractivePointsDisplay> createState() => _InteractivePointsDisplayState();
}

class _InteractivePointsDisplayState extends State<_InteractivePointsDisplay> {
  @override
  Widget build(BuildContext context) {
    return PointsCard(
      points: -1, 
      level: widget.user.level,
      xp: widget.user.xp,
    );
  }
}