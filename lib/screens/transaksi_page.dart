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
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Riwayat Transaksi', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: dummyTransaksi.length,
        itemBuilder: (context, index) {
          final trx = dummyTransaksi[index];
          
          String subtitleText = '';
          Color subtitleColor = AppColors.white.withAlpha(153);
          IconData iconData = Icons.shopping_cart;

          String monetaryText = '';
          if (trx.amount > 0) {
            monetaryText = "Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(trx.amount)}";
          }

          String pointsText = '';
          if (trx.pointsChange != null) {
            if (trx.pointsChange! > 0) {
              pointsText = "+${trx.pointsChange} Poin";
              subtitleColor = Colors.greenAccent;
              iconData = Icons.add_circle_outline;
            } else if (trx.pointsChange! < 0) {
              pointsText = "${trx.pointsChange} Poin";
              subtitleColor = Colors.redAccent;
              iconData = Icons.remove_circle_outline;
            }
          }

          if (monetaryText.isNotEmpty && pointsText.isNotEmpty) {
            subtitleText = "$monetaryText  •  $pointsText";
          } else if (monetaryText.isNotEmpty) {
            subtitleText = monetaryText;
          } else if (pointsText.isNotEmpty) {
            subtitleText = pointsText;
          } else {
            subtitleText = "No details";
          }

          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: subtitleColor.withAlpha(51),
                child: Icon(iconData, color: subtitleColor, size: 24),
              ),
              title: Text(trx.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.white)),
              subtitle: Text(subtitleText, style: GoogleFonts.poppins(color: subtitleColor)),
              trailing: Text(DateFormat('d MMM y').format(trx.date), style: GoogleFonts.poppins(color: AppColors.white.withAlpha(153))),
            ),
          ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0, delay: (100 * index).ms);
        },
      ),
    );
  }
}
