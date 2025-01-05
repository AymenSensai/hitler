class DashboardEntity {
  final int soldQuantities;
  final int purchasedQuantities;
  final String earnings;
  final String spendings;
  final int productCount;
  final int contactCount;
  final Map<String, int> salesData;
  final Map<String, int> purchaseData;

  DashboardEntity({
    required this.soldQuantities,
    required this.purchasedQuantities,
    required this.earnings,
    required this.spendings,
    required this.productCount,
    required this.contactCount,
    required this.salesData,
    required this.purchaseData,
  });
}
