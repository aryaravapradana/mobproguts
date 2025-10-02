import 'package:flutter/material.dart';
import 'package:project_midterms/data/transaction_data.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyTransaksi.length,
        itemBuilder: (context, index) {
          final trx = dummyTransaksi[index];

          final IconData icon;
          final Color color;
          String pointsText = '';

          if (trx.pointsChange != null) {
            if (trx.pointsChange! > 0) {
              icon = Icons.add_circle;
              color = AppColors.success;
              pointsText = '+${trx.pointsChange} Poin';
            } else {
              icon = Icons.remove_circle;
              color = AppColors.error;
              pointsText = '${trx.pointsChange} Poin';
            }
          } else {
            icon = Icons.shopping_cart;
            color = AppColors.primary;
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trx.title,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('d MMMM y, HH:mm').format(trx.date),
                          style: GoogleFonts.poppins(color: AppColors.onSurface.withAlpha(179), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (trx.amount > 0)
                        Text(
                          "Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(trx.amount)}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                      if (pointsText.isNotEmpty)
                        Text(
                          pointsText,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: color),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, delay: (100 * index).ms);
        },
      ),
    );
  }
}
