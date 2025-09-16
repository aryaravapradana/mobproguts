class Transaksi {
  final String title;
  final int amount;
  final DateTime date;

  Transaksi({required this.title, required this.amount, required this.date});
}

List<Transaksi> dummyTransaksi = [
  Transaksi(title: "Beli Kopi", amount: 50000, date: DateTime.now().subtract(const Duration(days: 1))),
  Transaksi(title: "Top Up Saldo", amount: 200000, date: DateTime.now().subtract(const Duration(days: 2))),
];
