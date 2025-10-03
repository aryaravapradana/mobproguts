import 'package:flutter/material.dart';

class Mission {
  final String title;
  final String description;
  final IconData icon;
  final int basePointReward;
  final double target;
  final double progress;
  final bool isClaimed;

  const Mission({
    required this.title,
    required this.description,
    required this.icon,
    required this.basePointReward,
    required this.target,
    required this.progress,
    this.isClaimed = false,
  });

  bool get isCompleted => progress >= target;
}
