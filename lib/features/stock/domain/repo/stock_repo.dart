import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_result.dart';

abstract class StockRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
}
