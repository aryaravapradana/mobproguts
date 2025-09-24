import 'package:project_midterms/models/voucher.dart';

class UserModel {
  String name;
  String email;
  String phone;
  String password;
  int saldo;
  int poin;
  int spending;
  double xp;
  List<Voucher> ownedVouchers;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.saldo,
    required this.poin,
    required this.spending,
    required this.xp,
    this.ownedVouchers = const [],
  });

  String get level {
    if (xp >= 1500) return "Diamond";
    if (xp >= 1100) return "Platinum";
    if (xp >= 800) return "Gold";
    if (xp >= 300) return "Silver";
    return "Bronze";
  }
}