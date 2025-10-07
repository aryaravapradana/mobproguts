import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/widgets/voucher_cost_display.dart';
import 'package:project_midterms/screens/redemption_success_screen.dart';

class VoucherDetailPage extends StatefulWidget {
  final Voucher voucher;
  final UserModel user;
  const VoucherDetailPage({super.key, required this.voucher, required this.user});

  @override
  State<VoucherDetailPage> createState() => _VoucherDetailPageState();
}

class _VoucherDetailPageState extends State<VoucherDetailPage> {
  int _getTierRank(String tierName) {
    return tiers.indexWhere((tier) => tier.name == tierName);
  }

  DateTime _calculateExpiryDate(DateTime baseDate, String tier) {
    switch (tier) {
      case 'Silver':
        return baseDate.add(const Duration(days: 15));
      case 'Gold':
        return baseDate.add(const Duration(days: 30));
      case 'Platinum':
        return baseDate.add(const Duration(days: 60));
      case 'Diamond':
        return baseDate.add(const Duration(days: 90));
      default: 
        return baseDate;
    }
  }

  void _redeemVoucher() {
    double discountPercentage = 0.0;
    switch (widget.user.level) {
      case "Bronze":
        discountPercentage = 5.0;
        break;
      case "Silver":
        discountPercentage = 10.0;
        break;
      case "Gold":
        discountPercentage = 15.0;
        break;
      case "Platinum":
        discountPercentage = 20.0;
        break;
      case "Diamond":
        discountPercentage = 25.0;
        break;
    }

    final int originalCost = widget.voucher.cost;
    final int discountedCost = (originalCost * (1 - (discountPercentage / 100))).round();

    if (widget.user.poin < discountedCost) {
      _showFeedbackDialog(
        title: "Redemption Failed",
        content: "You don't have enough points to redeem this voucher.",
        isSuccess: false,
      );
      return;
    }

    if (widget.voucher.requiredTier != null) {
      final userTierRank = _getTierRank(widget.user.level);
      final requiredTierRank = _getTierRank(widget.voucher.requiredTier!);

      if (userTierRank < requiredTierRank) {
        _showFeedbackDialog(
          title: "Peringatan Tier",
          content:
              "Tier Anda belum bisa redeem voucher ini. Anda harus menjadi member tier ${widget.voucher.requiredTier} untuk redeem voucher ini.",
          isSuccess: false,
        );
        return;
      }
    }

    final f = NumberFormat.decimalPattern('id');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Confirm Redemption'),
        content: Text(
            'Are you sure you want to spend ${f.format(discountedCost)} points to get this voucher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.lightGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.user.poin -= discountedCost;

                final redemptionDate = DateTime.now();
                final baseExpiryDate = widget.voucher.expiryDate ??
                    redemptionDate.add(const Duration(days: 30));
                final newExpiryDate =
                    _calculateExpiryDate(baseExpiryDate, widget.user.level);

                final redeemedVoucher = widget.voucher.copyWith(
                  redemptionDate: redemptionDate,
                  expiryDate: newExpiryDate,
                );
                redeemedVouchers.add(redeemedVoucher);
              });
              Navigator.pop(context); 
              _showFeedbackDialog(
                title: "Redemption Successful!",
                content:
                    "You have successfully redeemed '${widget.voucher.title}'. It has been added to your vouchers.",
                isSuccess: true,
              );
            },
            child: const Text('Redeem'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog({required String title, required String content, required bool isSuccess}) {
    if (isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RedemptionSuccessScreen(
            voucher: widget.voucher,
            user: widget.user,
            redemptionDate: DateTime.now(),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Row(
            children: [Icon(isSuccess ? Icons.check_circle : Icons.cancel, color: isSuccess ? AppColors.success : AppColors.error),
              const SizedBox(width: 10),
              Expanded(child: Text(title)),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool alreadyRedeemed = redeemedVouchers.any((v) => v.title == widget.voucher.title);

    final List<String> tncItems = [
      "Voucher is valid for one-time use only.",
      "Cannot be combined with other promotions.",
    ];

    if (widget.voucher.expiryDate != null) {
      final formattedDate = DateFormat('d MMMM yyyy').format(widget.voucher.expiryDate!);
      tncItems.add("Valid until $formattedDate.");
    }

    if (widget.voucher.requiredTier != null) {
      tncItems.add("Minimum tier required: ${widget.voucher.requiredTier}.");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Detail', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVoucherHeader(),
            const SizedBox(height: 32),
            _buildSection(
              title: "Terms and Conditions",
              items: tncItems, 
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: "How to Use",
              items: ["Present this voucher to the cashier upon payment."],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildRedeemButton(alreadyRedeemed),
    );
  }

  Widget _buildVoucherHeader() {
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias, 
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.amber.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.voucher.image,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.voucher.title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.voucher.description ?? "No description available.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withAlpha((255 * 0.8).round()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: AppColors.primary, size: 20),
                      const SizedBox(width: 12),
                      VoucherCostDisplay(voucher: widget.voucher, user: widget.user, fontSize: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).scale(delay: 200.ms);
  }

  Widget _buildSection({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onBackground),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => _buildTncItem(item)),
      ],
    );
  }

  Widget _buildTncItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(color: AppColors.onSurface, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemButton(bool alreadyRedeemed) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: alreadyRedeemed ? null : _redeemVoucher,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: alreadyRedeemed ? AppColors.darkGrey : AppColors.primary,
        ),
        icon: Icon(alreadyRedeemed ? Icons.check : Icons.card_giftcard, size: 20),
        label: Text(
          alreadyRedeemed ? "Already Redeemed" : "Redeem Now",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ).animate().slideY(begin: 1, end: 0, duration: 400.ms, curve: Curves.easeOut),
    );
  }
}