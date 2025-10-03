import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';

LinearGradient getGradientForTier(String level) {
  switch (level) {
    case 'Bronze':
      return const LinearGradient(
        colors: [Color(0xFFffe998), Color(0xFF57370d)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'Silver':
      return const LinearGradient(
        colors: [Color(0xFFe0e0e0), Color(0xFF757575)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'Gold':
      return const LinearGradient(
        colors: [Color(0xFFffd700), Color(0xFFf0c040)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'Diamond':
      return const LinearGradient(
        colors: [Color(0xFFb9f2ff), Color(0xFF3d5afe)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    default:
      return LinearGradient(
        colors: [AppColors.surface, AppColors.darkGrey.withAlpha(204)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}

Color getTextColorForTier(String level) {
  switch (level) {
    case 'Bronze':
      return const Color(0xFFffe998);
    case 'Silver':
      return AppColors.darkGrey;
    case 'Gold':
      return const Color(0xFF57370d);
    case 'Diamond':
      return Colors.white;
    default:
      return AppColors.primary;
  }
}

Color getGlowColorForTier(String level) {
  switch (level) {
    case 'Bronze':
      return const Color(0xFFc5753a);
    case 'Silver':
      return const Color(0xFFd6d6d6);
    case 'Gold':
      return const Color(0xFFffd700);
    case 'Diamond':
      return const Color(0xFF81d4fa);
    default:
      return AppColors.primary;
  }
}
