class Voucher {
  final String title;
  final int cost;
  final String image;
  final DateTime? expiryDate;
  final String? requiredTier;
  final String? description;
  final DateTime? redemptionDate; // New
  final bool isUsed; // New

  Voucher({
    required this.title,
    required this.cost,
    required this.image,
    this.expiryDate,
    this.requiredTier,
    this.description,
    this.redemptionDate, // New
    this.isUsed = false, // New
  });

  Voucher copyWith({
    DateTime? redemptionDate,
    bool? isUsed,
    DateTime? expiryDate,
  }) {
    return Voucher(
      title: title,
      cost: cost,
      image: image,
      expiryDate: expiryDate ?? this.expiryDate,
      requiredTier: requiredTier,
      description: description,
      redemptionDate: redemptionDate ?? this.redemptionDate,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}


class VoucherCategory {
  final String name;
  final List<Voucher> vouchers;

  VoucherCategory({
    required this.name,
    required this.vouchers,
  });
}