class Voucher {
  final String title;
  final int cost;
  final DateTime? expiryDate;
  final String? image;
  final String? requiredTier;

  Voucher({required this.title, required this.cost, this.expiryDate, this.image, this.requiredTier});
}
