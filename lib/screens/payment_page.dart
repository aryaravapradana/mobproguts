import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/data/transaction_data.dart';
import '../models/user.dart';
import '../models/transaksi.dart';
import 'scan_qr_page.dart';

class PaymentPage extends StatefulWidget {
  final UserModel user;
  const PaymentPage({super.key, required this.user});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final amountController = TextEditingController();
  final f = NumberFormat.decimalPattern('id');

  int _ambilNominal() {
    final raw = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(raw) ?? 0;
  }

  void makePayment() {
    final amount = _ambilNominal();

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nominal harus lebih dari 0')),
      );
      return;
    }

    final poinBaru = amount ~/ 1000;
    final double xpBaru = amount / 10000;

    setState(() {
      widget.user.poin += poinBaru;
      widget.user.xp += xpBaru;
      widget.user.spending += amount;
      dummyTransaksi.insert(
        0,
        Transaksi(
          title: "Belanja di Merchant",
          amount: amount,
          date: DateTime.now(),
        ),
      );
    });

    amountController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.gold,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.black),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Transaksi berhasil! +$poinBaru poin, +${xpBaru.toStringAsFixed(1)} XP',
                style: const TextStyle(color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scanQris() async {
    if (!mounted) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanQrPage()),
    );

    if (result != null && result is String) {
      final raw = result.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = int.tryParse(raw) ?? 0;

      if (amount > 0) {
        final poinBaru = amount ~/ 1000;
        final double xpBaru = amount / 10000;

        if (!mounted) return;
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text("Konfirmasi Pembayaran", style: TextStyle(color: AppColors.white)),
            content: Text(
              "Bayar Rp${f.format(amount)} dan dapatkan $poinBaru poin & ${xpBaru.toStringAsFixed(1)} XP?",
              style: TextStyle(color: AppColors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal", style: TextStyle(color: AppColors.white)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
                child: const Text("Bayar", style: TextStyle(color: AppColors.black)),
              ),
            ],
          ),
        );

        if (confirm == true) {
          setState(() {
            widget.user.poin += poinBaru;
            widget.user.xp += xpBaru;
            widget.user.spending += amount;
            dummyTransaksi.insert(
              0,
              Transaksi(
                title: "Pembayaran via QR",
                amount: amount,
                date: DateTime.now(),
              ),
            );
          });

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.gold,
              content: Text(
                "Transaksi berhasil! (+$poinBaru poin, +${xpBaru.toStringAsFixed(1)} XP)",
                style: TextStyle(color: AppColors.black),
              ),
            ),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR tidak mengandung nominal valid")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 1.5,
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Poin Saat Ini',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${f.format(widget.user.poin)} poin',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Level: ${widget.user.level}',
                      style: TextStyle(color: AppColors.white.withAlpha(153)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColors.white),
              decoration: const InputDecoration(
                labelText: 'Nominal Belanja',
                hintText: 'contoh: 250.000',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (digits.isEmpty) {
                  amountController.value = const TextEditingValue(text: '');
                  return;
                }
                final n = int.parse(digits);
                final pretty = f.format(n);
                amountController.value = TextEditingValue(
                  text: pretty,
                  selection: TextSelection.collapsed(offset: pretty.length),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, shape: const StadiumBorder()),
                onPressed: makePayment,
                child: const Text('Simpan Transaksi', style: TextStyle(color: AppColors.black)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.qr_code_scanner, color: AppColors.gold),
                label: const Text("Scan QR", style: TextStyle(color: AppColors.gold)),
                onPressed: _scanQris,
              ),
            ),
          ],
        ),
      ),
    );
  }
}