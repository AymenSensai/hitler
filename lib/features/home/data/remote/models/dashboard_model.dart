import 'package:json_annotation/json_annotation.dart';
import 'package:stocks_app/features/home/domain/entities/dashboard_entity.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel {
  @JsonKey(name: 'sold_quantities')
  final int soldQuantities;
  @JsonKey(name: 'purchased_quantities')
  final int purchasedQuantities;
  final String earnings;
  final String spendings;
  @JsonKey(name: 'product_count')
  final int productCount;
  @JsonKey(name: 'contact_count')
  final int contactCount;
  @JsonKey(name: 'sales_data')
  final Map<String, int> salesData;
  @JsonKey(name: 'purchase_data')
  final Map<String, int> purchaseData;

  DashboardModel({
    required this.soldQuantities,
    required this.purchasedQuantities,
    required this.earnings,
    required this.spendings,
    required this.productCount,
    required this.contactCount,
    required this.salesData,
    required this.purchaseData,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

  DashboardEntity toEntity() => DashboardEntity(
        soldQuantities: soldQuantities,
        purchasedQuantities: purchasedQuantities,
        earnings: earnings,
        spendings: spendings,
        productCount: productCount,
        contactCount: contactCount,
        salesData: salesData,
        purchaseData: purchaseData,
      );
}
