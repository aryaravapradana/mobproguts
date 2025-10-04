import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/membership_tier.dart';

final List<MembershipTier> tiers = [
  MembershipTier(
    name: 'Bronze',
    minXp: 0,
    icon: Icons.shield_outlined,
    imagePath: 'lib/assets/tier_logos/bronze.png',
    color: AppColors.bronze,
    perks: [
      Perk(name: "Welcome Bonus 100 Poin", icon: Icons.card_giftcard),
      Perk(name: "Diskon F&B 5%", icon: Icons.local_drink),
    ],
    description: "Level awal untuk semua member baru. Nikmati keuntungan dasar dan mulailah perjalanan Anda!",
  ),
  MembershipTier(
    name: 'Silver',
    minXp: 300,
    icon: Icons.star_border,
    imagePath: 'lib/assets/tier_logos/silver.png',
    color: AppColors.silver,
    perks: [
      Perk(name: "Cashback 3% per transaksi", icon: Icons.replay_circle_filled_outlined),
      Perk(name: "Diskon F&B 10%", icon: Icons.local_drink),
      Perk(name: "Voucher Spesial Ulang Tahun", icon: Icons.cake),
    ],
    description: "Level selanjutnya dengan lebih banyak keuntungan. Dapatkan promo personal yang disesuaikan untuk Anda.",
  ),
  MembershipTier(
    name: 'Gold',
    minXp: 800,
    icon: Icons.star,
    imagePath: 'lib/assets/tier_logos/gold.png',
    color: AppColors.gold,
    perks: [
      Perk(name: "Cashback 5% per transaksi", icon: Icons.replay_circle_filled_outlined),
      Perk(name: "Diskon F&B 15%", icon: Icons.local_drink),
      Perk(name: "Akses ke Promo Eksklusif", icon: Icons.local_offer),
      Perk(name: "Layanan Prioritas", icon: Icons.support_agent),
    ],
    description: "Level premium dengan akses ke promo eksklusif dari berbagai merchant partner kami.",
  ),
  MembershipTier(
    name: 'Platinum',
    minXp: 1100,
    icon: Icons.verified_outlined,
    imagePath: 'lib/assets/tier_logos/platinum.png',
    color: AppColors.platinum,
    perks: [
      Perk(name: "Cashback 7% per transaksi", icon: Icons.replay_circle_filled_outlined),
      Perk(name: "Diskon F&B 20%", icon: Icons.local_drink),
      Perk(name: "Akses ke Acara Spesial", icon: Icons.celebration),
      Perk(name: "Hadiah Eksklusif", icon: Icons.redeem),
    ],
    description: "Level elit dengan keuntungan maksimal dan layanan prioritas. Nikmati semua yang kami tawarkan.",
  ),
  MembershipTier(
    name: 'Diamond',
    minXp: 1500,
    icon: Icons.diamond_outlined,
    imagePath: 'lib/assets/tier_logos/diamond.png',
    color: AppColors.diamond,
    perks: [
      Perk(name: "Cashback 10% per transaksi", icon: Icons.replay_circle_filled_outlined),
      Perk(name: "Diskon F&B 25%", icon: Icons.local_drink),
      Perk(name: "Akses VIP ke Semua Acara", icon: FontAwesomeIcons.crown),
      Perk(name: "Manajer Akun Pribadi", icon: Icons.manage_accounts),
    ],
    description: "Level tertinggi yang melambangkan status dan loyalitas Anda. Dapatkan semua keuntungan terbaik.",
  ),
];