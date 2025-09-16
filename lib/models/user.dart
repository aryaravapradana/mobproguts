class UserModel {
  String name;
  String email;
  int saldo;
  int poin;
  int spending;

  UserModel({
    required this.name,
    required this.email,
    required this.saldo,
    required this.poin,
    required this.spending,
  });

  String get level {
    if (spending >= 10000000) return "Platinum";
    if (spending >= 5000000) return "Gold";
    if (spending >= 1000000) return "Silver";
    return "Bronze";
  }
}

// Dummy user untuk prototipe
UserModel currentUser = UserModel(
  name: "Arya",
  email: "test@mail.com",
  saldo: 500000,
  poin: 1500,
  spending: 2500000,
);
