

class Voucher {
  final String title;
  final int cost;
  final String image;
  final DateTime? expiryDate;
  final String? requiredTier;
  final String? description; // Added description

  Voucher({
    required this.title,
    required this.cost,
    required this.image,
    this.expiryDate,
    this.requiredTier,
    this.description, // Added description
  });
}