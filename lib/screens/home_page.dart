import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/dashboard_page.dart';
import 'package:project_midterms/screens/loyalty_screen.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import '../widgets/points_card.dart';
import 'account_page.dart';
import 'scan_qr_page.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePageContent(user: widget.user),
      VoucherPage(user: widget.user),
      AccountPage(user: widget.user),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // scanner QR
  void _openScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanQrPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: _openScanner,
        child: const Icon(Icons.qr_code_scanner, color: AppColors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: const Color(0xFF1E1E1E),
        child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildNavItem(Icons.home, "Home", 0),
                    _buildNavItem(Icons.local_offer, "Voucher", 1),
                  ],
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildNavItem(Icons.person, "Akun", 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? AppColors.gold : AppColors.white.withAlpha(153)),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.gold : AppColors.white.withAlpha(153),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final UserModel user;
  const HomePageContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text(
          "Hey, ${user.name}!",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
                );
              },
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage(user: user)),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoyaltyScreen(user: user)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PointsCard(
                  points: user.poin,
                  redeemableValue: 968, // This seems hardcoded, leaving for now
                  untilPlatinum: 1543, // This seems hardcoded, leaving for now
                  progress: user.xp / 1500, // Calculate progress based on xp
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Brand Loyalty",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoucherPage(user: user)),
                      );
                    },
                    child: const Text("View All", style: TextStyle(color: AppColors.gold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${user.poin} pts",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Icon(Icons.star, color: AppColors.gold, size: 20),
                        Text("4.8", style: TextStyle(fontSize: 12, color: AppColors.white)), // Hardcoded
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Conversion Recommendation",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.account_balance, size: 50, color: AppColors.white),
                Icon(Icons.person, size: 50, color: AppColors.white),
                Icon(Icons.build, size: 50, color: AppColors.white),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("⏱ Estimated transfer time up to 30 minutes", style: TextStyle(color: AppColors.white)),
                  Text("🔄 10000 Membership Rewards = 1000 Aeroplan", style: TextStyle(color: AppColors.white)),
                  Text("📌 Minimum transfer amount 1000 points", style: TextStyle(color: AppColors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}