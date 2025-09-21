import 'package:flutter/material.dart';

class Perk {
  final String name;
  final IconData icon;

  Perk({required this.name, required this.icon});
}

class MembershipTier {
  final String name;
  final int minXp;
  final IconData icon;
  final Color color;
  final List<Perk> perks;

  MembershipTier({
    required this.name,
    required this.minXp,
    required this.icon,
    required this.color,
    required this.perks,
  });
}