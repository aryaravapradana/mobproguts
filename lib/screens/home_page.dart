import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/dashboard_page.dart';
import 'package:project_midterms/screens/membership_detail_page.dart';
import 'package:project_midterms/screens/voucher_page.dart';
import '../widgets/points_card.dart';
import 'account_page.dart';
import 'scan_qr_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      MaterialPageRoute(builder: (_) => ScanQrPage(user: widget.user)),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildNavItem(Icons.home, "Home", 0),
                  ],
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildNavItem(Icons.person, "Akun", 1),
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
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
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
                  MaterialPageRoute(builder: (context) => MembershipDetailPage(user: user)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PointsCard(
                  points: user.poin,
                  redeemableValue: user.poin * 0.1, // Assuming 1 point = $0.1
                  nextLevel: user.level,
                  progress: user.xp / 1500, // Calculate progress based on xp
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Brand Loyalty",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
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
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Assuming 3 brands
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 16, right: index == 2 ? 16 : 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.gold,
                          child: Icon(Icons.store, color: AppColors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Brand ${index + 1}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${user.poin} pts",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.white.withAlpha(153),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Conversion Recommendation",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildRecommendationRow(Icons.airplane_ticket, "Aeroplan", "10000 -> 1000"),
                  Divider(color: Colors.white24),
                  _buildRecommendationRow(Icons.hotel, "Marriott Bonvoy", "10000 -> 1500"),
                  Divider(color: Colors.white24),
                  _buildRecommendationRow(Icons.shopping_bag, "Hilton Honors", "10000 -> 2000"),
                ],
              ),
            ),
          ],
        ).animate().fade(duration: 500.ms),
      ),
    );
  }

  Widget _buildRecommendationRow(IconData icon, String title, String conversion) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              Text(
                "Membership Rewards",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.white.withAlpha(153),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            conversion,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}