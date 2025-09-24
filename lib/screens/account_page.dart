import 'package:flutter/material.dart';
import 'membership_detail_page.dart';
import 'settings_page.dart';
import '../models/user.dart'; // Import data pengguna
import '../colors.dart';

// 1. Ubah menjadi StatefulWidget
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF2C2C2E),
                          child: Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 2. Ambil nama dari currentUser, bukan hardcoded
                            Text(
                              currentUser.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // 3. Ambil no. telepon dari currentUser
                            Text(
                              currentUser.phone,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.chevron_right, color: Colors.grey[600]),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        // Navigasi ke halaman detail member
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MembershipDetailPage()),
                        );
                        // Refresh halaman ini saat kembali
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2E),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              color: AppColors.gold,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BESTIE', // Ini bisa diubah jadi currentUser.level jika mau
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Anggota sejak 25 Agu 2024',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNavItem(Icons.monetization_on, 'A-Poin', () {}),
                    buildNavItem(Icons.star, 'Alfa Star', () {}),
                    buildNavItem(
                      Icons.local_offer_outlined,
                      'Alfa Stamp',
                      () {},
                    ),
                    buildNavItem(
                      Icons.card_giftcard_outlined,
                      'Voucher',
                      () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildInfoCard(
              icon: Icons.email,
              title: 'Kamu belum verifikasi email',
              subtitle: 'Yuk, segera verifikasi emailmu',
              iconColor: AppColors.gold,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            buildInfoCard(
              icon: Icons.flag,
              title: 'Misi Bertingkat',
              subtitle: '0/7 misi selesai\nSisa waktu 14 hari',
              iconColor: Colors.cyan,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            buildListTile(
              Icons.settings,
              'Pengaturan Akun',
              'Ganti Password, Ganti PIN & Daftar Alamat',
              () async {
                // 4. Pergi ke halaman pengaturan, TUNGGU sampai kembali
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                // 5. Setelah kembali, panggil setState untuk refresh halaman
                setState(() {});
              },
            ),
            buildListTile(Icons.rate_review, 'Rating & ulasan', '', () {}),
            buildListTile(
              Icons.notifications,
              'Atur Notifikasi',
              'Notifikasi belum aktif. Aktifkan sekarang',
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String text, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: AppColors.gold, size: 30),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: const Color(0xFF2C2C2E),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }

  Widget buildListTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[400]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: const TextStyle(fontSize: 12))
            : null,
        trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }
}