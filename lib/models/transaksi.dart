class Transaksi {
  final String title;
  final int amount; // Monetary amount, 0 if not applicable
  final int? pointsChange; // Positive for earned, negative for redeemed
  final DateTime date;

  Transaksi({required this.title, required this.amount, this.pointsChange, required this.date});
}