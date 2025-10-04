import 'package:flutter/material.dart';

class Notification {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final bool isRead;
  final DateTime date;
  final double? progress;
  final String? tag;
  final Color? tagColor;
  final String? buttonText;
  final List<Color>? gradientColors;

  Notification({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.isRead,
    required this.date,
    this.progress,
    this.tag,
    this.tagColor,
    this.buttonText,
    this.gradientColors,
  });
}