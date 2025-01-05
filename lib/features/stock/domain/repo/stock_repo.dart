import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_result.dart';
import '../../../contacts/domain/entities/contact_entity.dart';
import '../../../products/data/remote/models/order_request_body.dart';

abstract class StockRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<List<ContactEntity>>> getContacts();
  Future<ApiResult<void>> placeOrder(OrderRequestBody order);
}
