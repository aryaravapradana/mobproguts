import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_midterms/models/user.dart';

class VoucherDetailPage extends StatefulWidget {
  final Voucher voucher;
  final UserModel user;
  const VoucherDetailPage({super.key, required this.voucher, required this.user});

  @override
  State<VoucherDetailPage> createState() => _VoucherDetailPageState();
}

class _VoucherDetailPageState extends State<VoucherDetailPage> {
  void _redeemVoucher() {
    if (widget.user.poin < widget.voucher.cost) {
      _showFeedbackDialog(
        title: "Redemption Failed",
        content: "You don't have enough points to redeem this voucher.",
        isSuccess: false,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Confirm Redemption'),
        content: Text('Are you sure you want to spend ${widget.voucher.cost} points to get this voucher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.lightGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.user.poin -= widget.voucher.cost;
                redeemedVouchers.add(widget.voucher);
              });
              Navigator.pop(context); // Close confirmation dialog
              _showFeedbackDialog(
                title: "Redemption Successful!",
                content: "You have successfully redeemed '${widget.voucher.title}'. It has been added to your vouchers.",
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
              Navigator.pop(context); // Close the dialog
              if (isSuccess) {
                Navigator.pop(context, true); // Pop the detail page with a `true` result
              }
            },
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool alreadyRedeemed = redeemedVouchers.any((v) => v.title == widget.voucher.title);

    // --- Create dynamic T&Cs ---
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
    // ---------------------------

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
              items: tncItems, // Use the dynamic list
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
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.voucher.title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.monetization_on, color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                Text(
                  "${widget.voucher.cost} points",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
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