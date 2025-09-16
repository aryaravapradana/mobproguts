class Voucher {
  final String title;
  final int cost;

  Voucher({required this.title, required this.cost});
}

List<Voucher> dummyVouchers = [
  Voucher(title: "Diskon 10% di Coffee Shop", cost: 500),
  Voucher(title: "Voucher Rp50.000", cost: 1000),
  Voucher(title: "Free Parking 2 Jam", cost: 700),
];
