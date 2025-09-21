// home page 
import 'package:flutter/material.dart';
import '../widgets/points_card.dart';
import 'account_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 

  final List<Widget> _pages = [
    const HomePageContent(), 
    const Center(child: Text('Contacts Page')), 
    const Center(child: Text('Browse Page')), 
    const Center(child: Text('Checkout Page')), 
    const AccountPage(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Browse"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Checkout"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Akun"), 
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f7f6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFd4a373),
        elevation: 0,
        title: const Text(
          "FOR YOU",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.person, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PointsCard(
                points: 131567,
                redeemableValue: 968,
                untilPlatinum: 1543,
                progress: 0.9,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "My Brand Loyalty",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(color: Colors.orange),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(2, 4),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("21,948 pts",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 4),
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        Text("4.8", style: TextStyle(fontSize: 12)),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.account_balance, size: 50),
                Icon(Icons.person, size: 50),
                Icon(Icons.build, size: 50),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("⏱ Estimated transfer time up to 30 minutes"),
                  Text("🔄 10000 Membership Rewards = 1000 Aeroplan"),
                  Text("📌 Minimum transfer amount 1000 points"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}