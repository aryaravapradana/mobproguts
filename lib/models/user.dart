import 'package:project_midterms/models/voucher.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String password;
  int poin;
  int spending;
  double xp;
  String qrCode;
  List<Voucher> ownedVouchers;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.poin,
    required this.spending,
    required this.xp,
    required this.qrCode,
    this.ownedVouchers = const [],
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    int? poin,
    int? spending,
    double? xp,
    String? qrCode,
    List<Voucher>? ownedVouchers,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      poin: poin ?? this.poin,
      spending: spending ?? this.spending,
      xp: xp ?? this.xp,
      qrCode: qrCode ?? this.qrCode,
      ownedVouchers: ownedVouchers ?? this.ownedVouchers,
    );
  }

  String get level {
    if (xp >= 1500) return "Diamond";
    if (xp >= 1100) return "Platinum";
    if (xp >= 800) return "Gold";
    if (xp >= 300) return "Silver";
    return "Bronze";
  }
}