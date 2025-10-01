import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MemberPage extends StatelessWidget {
  final UserModel user;
  const MemberPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Member Info', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color(0xFF1E1E1E),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.gold,
                    child: Icon(Icons.person, size: 60, color: AppColors.black),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.white.withAlpha(153),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: AppColors.white.withAlpha(50)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn("Level", user.level),
                      _buildInfoColumn("Points", user.poin.toString()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  QrImageView(
                    data: user.qrCode,
                    version: QrVersions.auto,
                    size: 150.0,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 500.ms).scale(delay: 200.ms),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.white.withAlpha(153),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
      ],
    );
  }
}
