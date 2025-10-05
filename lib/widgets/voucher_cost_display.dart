import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/voucher.dart';
import 'package:project_midterms/models/user.dart';

class VoucherCostDisplay extends StatelessWidget {
  final Voucher voucher;
  final UserModel user;
  final double fontSize;

  const VoucherCostDisplay({
    super.key,
    required this.voucher,
    required this.user,
    this.fontSize = 12, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    final int originalCost = voucher.cost;
    double discountPercentage = 0.0;

    switch (user.level) {
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
        discountPercentage = 20.0; // Assuming 20% for Platinum
        break;
      case "Diamond":
        discountPercentage = 25.0; // Assuming 25% for Diamond
        break;
    }

    if (discountPercentage > 0) {
      final double discountedCost = originalCost * (1 - (discountPercentage / 100));
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              NumberFormat.decimalPattern('id').format(originalCost),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                color: AppColors.lightGrey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "${NumberFormat.decimalPattern('id').format(discountedCost.round())} points",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        "${NumberFormat.decimalPattern('id').format(originalCost)} points",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: AppColors.primary,
        ),
      );
    }
  }
}
