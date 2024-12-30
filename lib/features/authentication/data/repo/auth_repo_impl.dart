import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../remote/auth_api_service.dart';
import '../remote/models/forgot_password_request_body.dart';
import '../remote/models/google_sign_in_request_body.dart';
import '../remote/models/login_request_body.dart';
import '../remote/models/register_request_body.dart';
import '../remote/models/reset_password_request_body.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthApiService _apiService;

  AuthRepoImpl(this._apiService);

  @override
  Future<ApiResult<TokenEntity>> login(String email, String password) async {
    try {
      final response = await _apiService
          .login(LogInRequestBody(email: email, password: password));

      return ApiResult.success(response.toTokenEntity());
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<TokenEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.register(
        RegisterRequestBody(
          name: email,
          email: email,
          password: password,
        ),
      );
      return ApiResult.success(response.toTokenEntity());
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<TokenEntity>> googleSignIn(String idToken) async {
    try {
      final response = await _apiService
          .googleSignIn(GoogleSignInRequestBody(idToken: idToken));
      return ApiResult.success(response.toTokenEntity());
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<TokenEntity>> forgotPassword(String email) async {
    try {
      final response = await _apiService
          .forgotPassword(ForgotPasswordRequestBody(email: email));
      return ApiResult.success(response.toTokenEntity());
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<TokenEntity>> resetPassword(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await _apiService.resetPassword(
        ResetPasswordRequestBody(
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return ApiResult.success(response.toTokenEntity());
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
