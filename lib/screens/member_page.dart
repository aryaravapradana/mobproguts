import 'package:flutter/material.dart';
import 'package:project_midterms/data/membership_data.dart';
import 'package:project_midterms/models/user.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;
import 'package:project_midterms/helpers/tier_style.dart';

class MemberPage extends StatefulWidget {
  final UserModel user;
  const MemberPage({super.key, required this.user});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFlipped = false;
  bool _isHovering = false;

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
        title: Text(
          'Member Card',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
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
                      ? _buildCardFace(isFront: false, level: widget.user.level)
                      : _buildCardFace(isFront: true, level: widget.user.level),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFace({required bool isFront, required String level}) {
    final Matrix4 transform = isFront
        ? Matrix4.identity()
        : (Matrix4.identity()..rotateY(math.pi));

    final glowColor = getGlowColorForTier(level);
    final isHovering = _isHovering;

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 320,
        height: 480,
        transform: Matrix4.translationValues(0, isHovering ? -20 : 0, 0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: glowColor.withAlpha((255 * (isHovering ? 0.85 : 0.6)).round()),
              blurRadius: isHovering ? 35 : 20,
              spreadRadius: isHovering ? 4 : 2,
            ),
          ],
        ),
        child: isFront ? _buildFrontContent() : _buildBackContent(),
      ),
    );
  }

  Widget _buildFrontContent() {
    final tier = tiers.firstWhere((t) => t.name == widget.user.level);
    final cardGradient = getGradientForTier(widget.user.level);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: cardGradient)),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha((255 * 0.1).round()),
                  Colors.black.withAlpha((255 * 0.2).round()),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.2),
            child: Image.asset(tier.imagePath!, width: 200, height: 200),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.level.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.user.name,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha((255 * 0.95).round()),
                    shadows: [
                      const Shadow(
                        blurRadius: 4.0,
                        color: Colors.black45,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "MEMBER ID: ${widget.user.id}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withAlpha((255 * 0.8).round()),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Tap to scan QR",
                      style: GoogleFonts.poppins(
                        color: Colors.white.withAlpha((255 * 0.7).round()),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.touch_app,
                      color: Colors.white.withAlpha((255 * 0.7).round()),
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
            eyeStyle: const QrEyeStyle(
              color: AppColors.onPrimary,
              eyeShape: QrEyeShape.square,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              color: AppColors.onPrimary,
              dataModuleShape: QrDataModuleShape.circle,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Scan this code for transactions",
            style: GoogleFonts.poppins(
              color: AppColors.onSurface,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
