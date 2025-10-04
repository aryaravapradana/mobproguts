import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/redeem_history_data.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RedeemedVoucherDetailPage extends StatefulWidget {
  final Voucher voucher;

  const RedeemedVoucherDetailPage({super.key, required this.voucher});

  @override
  State<RedeemedVoucherDetailPage> createState() => _RedeemedVoucherDetailPageState();
}

class _RedeemedVoucherDetailPageState extends State<RedeemedVoucherDetailPage> {
  late Voucher _voucher;

  @override
  void initState() {
    super.initState();
    _voucher = widget.voucher;
  }

  void _markAsUsed() {
    setState(() {
      final index = redeemedVouchers.indexWhere((v) => v.redemptionDate == _voucher.redemptionDate);
      if (index != -1) {
        redeemedVouchers[index] = _voucher.copyWith(isUsed: true);
        _voucher = redeemedVouchers[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Detail', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTicketView(context),
            const SizedBox(height: 24),
            _buildUsageButton(),
            const SizedBox(height: 24),
            _buildSectionTitle('Terms & Conditions'),
            _buildTncItem(_voucher.description ?? 'No specific terms and conditions for this voucher.'),
            _buildTncItem('Voucher is valid for one-time use only.'),
            _buildTncItem('Cannot be combined with other promotions.'),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketView(BuildContext context) {
    final redemptionDate = _voucher.redemptionDate != null
        ? DateFormat('d MMM yyyy, HH:mm').format(_voucher.redemptionDate!.toUtc().add(const Duration(hours: 7)))
        : 'Not available';
    final expiryDate = _voucher.expiryDate != null
        ? DateFormat('d MMMM yyyy').format(_voucher.expiryDate!)
        : 'No expiry date';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.darkGrey),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(_voucher.image, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _voucher.title,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 8),
                      _buildStatusChip(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDashedDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: QrImageView(
              data: 'data:text/html,<html><body><h1>Easter egg Halooooo</h1></body></html>',
              version: QrVersions.auto,
              size: 150.0,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(color: Colors.black, eyeShape: QrEyeShape.square),
              dataModuleStyle: const QrDataModuleStyle(color: Colors.black, dataModuleShape: QrDataModuleShape.square),
            ),
          ),
          _buildDashedDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildInfoRow('Redeemed on', redemptionDate),
                _buildInfoRow('Expires on', expiryDate),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    String text;
    Color color;
    IconData icon;

    if (_voucher.isUsed) {
      text = 'Used';
      color = AppColors.error;
      icon = Icons.cancel;
    } else if (_voucher.expiryDate != null && _voucher.expiryDate!.isBefore(DateTime.now())) {
      text = 'Expired';
      color = AppColors.darkGrey;
      icon = Icons.timer_off;
    } else {
      text = 'Active';
      color = AppColors.success;
      icon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildUsageButton() {
    final bool canBeUsed = !_voucher.isUsed && (_voucher.expiryDate == null || _voucher.expiryDate!.isAfter(DateTime.now()));

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: canBeUsed ? _markAsUsed : null,
        icon: const Icon(Icons.qr_code_scanner),
        label: Text(_voucher.isUsed ? 'Already Used' : 'Mark as Used'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.darkGrey,
        ),
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: List.generate(30, (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : AppColors.darkGrey,
            height: 1,
          ),
        )),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.lightGrey)),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onBackground),
    );
  }

  Widget _buildTncItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.circle, size: 8, color: AppColors.lightGrey),
          ),
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
}
