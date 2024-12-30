import '../../../../core/networking/api_result.dart';
import '../entities/token_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<TokenEntity>> login(String email, String password);
  Future<ApiResult<TokenEntity>> register(
    String name,
    String email,
    String password,
  );
  Future<ApiResult<TokenEntity>> googleSignIn(String idToken);
  Future<ApiResult<TokenEntity>> forgotPassword(String email);
  Future<ApiResult<TokenEntity>> resetPassword(
    String email,
    String password,
    String passwordConfirmation,
  );
}
