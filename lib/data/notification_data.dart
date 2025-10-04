import 'package:flutter/material.dart' hide Notification;
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/notification.dart';

List<Notification> notifications = [
  Notification(
    title: 'Voucher Diskon 50% Untukmu!',
    subtitle: 'Jangan lewatkan kesempatan emas ini. Klaim voucher diskon 50% untuk semua produk. Terbatas!',
    time: 'Tinggal 2 Hari Lagi',
    icon: Icons.local_offer,
    isRead: false,
    date: DateTime.now(),
    progress: 0.25,
    tag: 'Tinggal 2 Hari Lagi',
    tagColor: AppColors.danger,
    buttonText: 'Lihat',
    gradientColors: [AppColors.danger, AppColors.primaryDark],
  ),
  Notification(
    title: 'Poin Ganda Setiap Hari Jumat',
    subtitle: 'Kumpulkan poin lebih cepat! Setiap transaksi di hari Jumat akan mendapatkan poin ganda. Makin untung!',
    time: 'Tiap Jumat',
    icon: Icons.star,
    isRead: false,
    date: DateTime.now(),
    progress: 1.0,
    tag: 'Tiap Jumat',
    tagColor: AppColors.primary,
    buttonText: 'Lihat',
    gradientColors: [AppColors.primary, AppColors.primaryDark],
  ),
  Notification(
    title: 'Transaksi Berhasil',
    subtitle: 'Pembayaranmu di Merchant Z telah berhasil. Kamu mendapatkan 500 poin.',
    time: '1d ago',
    icon: Icons.receipt_long,
    isRead: true,
    date: DateTime.now().subtract(const Duration(days: 1)),
    gradientColors: [AppColors.primary, AppColors.primaryDark],
  ),
  Notification(
    title: 'Profilmu Belum Lengkap',
    subtitle: 'Lengkapi profilmu dan dapatkan 100 poin gratis!',
    time: '2d ago',
    icon: Icons.account_circle,
    isRead: true,
    date: DateTime.now().subtract(const Duration(days: 2)),
    gradientColors: [AppColors.danger, AppColors.primaryDark],
  ),
];