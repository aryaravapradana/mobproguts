import 'package:flutter/material.dart';
import 'package:project_midterms/models/mission.dart';

final List<Mission> dummyMissions = [
  const Mission(
    title: "Check-in Harian",
    description: "Masuk ke aplikasi setiap hari untuk mendapatkan bonus poin.",
    icon: Icons.calendar_today,
    basePointReward: 10,
    target: 1,
    progress: 1,
    isClaimed: false, // Completed, ready to claim
  ),
  const Mission(
    title: "Pembelanjaan Pertama",
    description: "Lakukan transaksi pertamamu di merchant mana saja.",
    icon: Icons.shopping_cart,
    basePointReward: 50,
    target: 1,
    progress: 0, // Not started
  ),
  const Mission(
    title: "Jelajah Kuliner",
    description: "Lakukan 5 kali transaksi di kategori F&B.",
    icon: Icons.fastfood,
    basePointReward: 100,
    target: 5,
    progress: 3, // In progress
  ),
  const Mission(
    title: "Raja Belanja",
    description: "Habiskan total Rp 500.000 di semua merchant.",
    icon: Icons.monetization_on,
    basePointReward: 250,
    target: 500000,
    progress: 175000, // In progress
  ),
  const Mission(
    title: "Ajak Teman",
    description: "Ajak 1 teman untuk bergabung menggunakan kode referalmu.",
    icon: Icons.person_add,
    basePointReward: 200,
    target: 1,
    progress: 1,
    isClaimed: true, // Already claimed
  ),
];
