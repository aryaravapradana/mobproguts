class Transaksi {
  final String title;
  final int amount; 
  final int? pointsChange; 
  final DateTime date;

  Transaksi({required this.title, required this.amount, this.pointsChange, required this.date});
}