import 'package:flutter/material.dart';
import 'package:project_midterms/colors.dart';
import 'auth/login_page.dart';

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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.black,
        primaryColor: AppColors.gold,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.white,
              displayColor: AppColors.white,
            ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
