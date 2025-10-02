import 'package:flutter/material.dart';
import 'package:project_midterms/models/user.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;

class MemberPage extends StatefulWidget {
  final UserModel user;
  const MemberPage({super.key, required this.user});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Card', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * -math.pi;
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);
              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: _controller.value >= 0.5
                    ? _buildCardFace(isFront: false)
                    : _buildCardFace(isFront: true),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardFace({required bool isFront}) {
    final Matrix4 transform = isFront
        ? Matrix4.identity()
        : (Matrix4.identity()..rotateY(math.pi));

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: SizedBox(
        width: 320,
        height: 480,
        child: Card(
          elevation: 12,
          shadowColor: AppColors.primary.withAlpha(128),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: isFront ? _buildFrontContent() : _buildBackContent(),
        ),
      ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.9, 0.9)),
    );
  }

  Widget _buildFrontContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [AppColors.surface, AppColors.darkGrey.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.user.level.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 2,
                  ),
                ),
                const Icon(Icons.star, color: AppColors.primary, size: 28),
              ],
            ),
            const Spacer(),
            Text(
              widget.user.name,
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "MEMBER ID: ${widget.user.id}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.lightGrey,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tap to scan QR",
                  style: GoogleFonts.poppins(color: AppColors.lightGrey, fontSize: 12),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.touch_app, color: AppColors.lightGrey, size: 16),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(
            data: widget.user.qrCode,
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
            eyeStyle: QrEyeStyle(color: AppColors.onPrimary, eyeShape: QrEyeShape.square),
            dataModuleStyle: QrDataModuleStyle(color: AppColors.onPrimary, dataModuleShape: QrDataModuleShape.circle),
          ),
          const SizedBox(height: 24),
          Text(
            "Scan this code for transactions",
            style: GoogleFonts.poppins(color: AppColors.onSurface, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
