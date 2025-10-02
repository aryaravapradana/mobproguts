class Voucher {
  final String title;
  final int cost;
  final DateTime? date;
  final String? image;

  Voucher({required this.title, required this.cost, this.date, this.image});
}