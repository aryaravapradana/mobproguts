import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/home_page.dart'; 
// import 'package:intl/intl.dart';
import 'screens/payment_page.dart';

void main() {
  runApp(const LoyaltyApp());
}

class LoyaltyApp extends StatelessWidget {
  const LoyaltyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loyalty Points Mall',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/home': (context) => const HomePage(),
        '/payment': (context) => const PaymentPage(),
      },
    );
  }
}
