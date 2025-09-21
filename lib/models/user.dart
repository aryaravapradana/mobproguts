class UserModel {
  String name;
  String email;
  int saldo;
  int poin;
  int spending;
  double xp;

  UserModel({
    required this.name,
    required this.email,
    required this.saldo,
    required this.poin,
    required this.spending,
    required this.xp,
  });

  String get level {
    if (xp >= 1500) return "Diamond";
    if (xp >= 1100) return "Platinum";
    if (xp >= 800) return "Gold";
    if (xp >= 300) return "Silver";
    return "Bronze";
  }
}

UserModel currentUser = UserModel(
  name: "Arya",
  email: "test@mail.com",
  saldo: 500000,
  poin: 1500,
  spending: 2500000,
  xp: 250.0,
);