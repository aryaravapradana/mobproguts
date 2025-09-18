import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import '../models/transaksi.dart';
import 'scan_qr_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final amountController = TextEditingController();
  final f = NumberFormat.decimalPattern('id');

  // --- helper ambil nominal dari TextField
  int _ambilNominal() {
    final raw = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(raw) ?? 0;
  }

  // --- transaksi manual (tanpa scan)
  void makePayment() {
    final amount = _ambilNominal();

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nominal harus lebih dari 0')),
      );
      return;
    }

    final poinBaru = amount ~/ 1000;

    setState(() {
      currentUser.poin += poinBaru;
      currentUser.spending += amount;
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
        backgroundColor: Colors.green.shade700,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Transaksi Rp${f.format(amount)} berhasil, +$poinBaru poin!',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- transaksi via scan QR
  Future<void> _scanQris() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanQrPage()),
    );

    if (result != null && result is String) {
      // ambil hanya angka dari QR
      final raw = result.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = int.tryParse(raw) ?? 0;

      if (amount > 0) {
        final poinBaru = amount ~/ 1000;

        // tampilkan konfirmasi sebelum proses transaksi
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Konfirmasi Pembayaran"),
            content: Text(
              "Bayar Rp${f.format(amount)} dan dapat $poinBaru poin?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Bayar"),
              ),
            ],
          ),
        );

        if (confirm == true) {
          setState(() {
            currentUser.poin += poinBaru;
            currentUser.spending += amount;
            dummyTransaksi.insert(
              0,
              Transaksi(
                title: "Pembayaran via QR",
                amount: amount,
                date: DateTime.now(),
              ),
            );
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green.shade700,
              content: Text(
                "Transaksi Rp${f.format(amount)} berhasil (+$poinBaru poin)",
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR tidak mengandung nominal valid")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- kartu info poin
            Card(
              elevation: 1.5,
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
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${f.format(currentUser.poin)} poin',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Level: ${currentUser.level}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
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
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: makePayment,
                child: const Text('Simpan Transaksi'),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan QR"),
                onPressed: _scanQris,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
