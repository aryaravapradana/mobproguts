import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/membership_tier.dart';

final List<MembershipTier> tiers = [
  MembershipTier(
    name: 'Bronze',
    minXp: 0,
    icon: Icons.shield_outlined,
    color: AppColors.bronze,
    perks: [
      Perk(name: "Poin Reguler", icon: Icons.monetization_on),
    ],
    description: "Level awal untuk semua member baru. Nikmati keuntungan dasar dan mulailah perjalanan Anda!",
  ),
  MembershipTier(
    name: 'Silver',
    minXp: 300,
    icon: Icons.star_border,
    color: AppColors.silver,
    perks: [
      Perk(name: "Poin Reguler", icon: Icons.monetization_on),
      Perk(name: "Promo Personal", icon: Icons.local_offer),
    ],
    description: "Level selanjutnya dengan lebih banyak keuntungan. Dapatkan promo personal yang disesuaikan untuk Anda.",
  ),
  MembershipTier(
    name: 'Gold',
    minXp: 800,
    icon: Icons.star,
    color: AppColors.goldTier,
    perks: [
      Perk(name: "Poin Reguler", icon: Icons.monetization_on),
      Perk(name: "Promo Personal", icon: Icons.local_offer),
      Perk(name: "Promo Merchant", icon: Icons.storefront),
    ],
    description: "Level premium dengan akses ke promo eksklusif dari berbagai merchant partner kami.",
  ),
  MembershipTier(
    name: 'Platinum',
    minXp: 1100,
    icon: Icons.verified_outlined,
    color: AppColors.platinum,
    perks: [
      Perk(name: "Poin Reguler", icon: Icons.monetization_on),
      Perk(name: "Promo Personal", icon: Icons.local_offer),
      Perk(name: "Promo Merchant", icon: Icons.storefront),
    ],
    description: "Level elit dengan keuntungan maksimal dan layanan prioritas. Nikmati semua yang kami tawarkan.",
  ),
  MembershipTier(
    name: 'Diamond',
    minXp: 1500,
    icon: Icons.diamond_outlined,
    color: AppColors.diamond,
    perks: [
      Perk(name: "Poin Reguler", icon: Icons.monetization_on),
      Perk(name: "Promo Personal", icon: Icons.local_offer),
      Perk(name: "Promo Merchant", icon: Icons.storefront),
    ],
    description: "Level tertinggi yang melambangkan status dan loyalitas Anda. Dapatkan semua keuntungan terbaik.",
  ),
];
