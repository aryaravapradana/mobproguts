import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/transaction_data.dart';
import '../models/user.dart';
import '../models/transaksi.dart';

import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final UserModel user;
  const PaymentPage({super.key, required this.user});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final amountController = TextEditingController();
  final f = NumberFormat.decimalPattern('id');

  int _getAmount() {
    final raw = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(raw) ?? 0;
  }

  void _makePayment() {
    final amount = _getAmount();

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount must be greater than 0'), backgroundColor: AppColors.error),
      );
      return;
    }

    final pointsEarned = amount ~/ 100;
    final double xpEarned = amount / 10000;

    setState(() {
      widget.user.poin += pointsEarned;
      widget.user.xp += xpEarned;
      widget.user.spending += amount;
      dummyTransaksi.insert(
        0,
        Transaksi(
          title: "In-Store Purchase",
          amount: amount,
          pointsChange: pointsEarned,
          date: DateTime.now(),
        ),
      );
    });

    amountController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.success,
        content: Text('Transaction successful! +$pointsEarned points, +${xpEarned.toStringAsFixed(1)} XP'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrentPointsCard(),
            const SizedBox(height: 24),
            _buildAmountInput(),
            const SizedBox(height: 24),
            _buildSaveButton(),
            const SizedBox(height: 12),
            _buildScanQrButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPointsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Points', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  f.format(widget.user.poin),
                  style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                const SizedBox(width: 8),
                Text('points', style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(179)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: 'Purchase Amount',
        prefixText: 'Rp ',
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits.isEmpty) {
          amountController.clear();
          return;
        }
        final n = int.parse(digits);
        final formatted = f.format(n);
        amountController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      onPressed: _makePayment,
      icon: const Icon(Icons.check, size: 20),
      label: const Text('Save Transaction'),
    );
  }

  Widget _buildScanQrButton() {
    return OutlinedButton.icon(
      onPressed: () { /* QR Scan Logic Here */ },
      icon: const Icon(Icons.qr_code_scanner, size: 20),
      label: const Text("Scan QR to Pay"),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}