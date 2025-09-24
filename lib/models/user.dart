class UserModel {
  String name;
  String email;
  String phone;
  String address;
  String password; 
  int saldo;
  int poin;
  int spending;
  double xp;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
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
  email: "arya@mail.com",
  phone: "081234567890",
  address: "Jl. Sudirman No. 123, Jakarta",
  password: "password123",
  saldo: 500000,
  poin: 1500,
  spending: 2500000,
  xp: 250.0,
);