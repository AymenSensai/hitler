import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import 'models/forgot_password_request_body.dart';
import 'models/google_sign_in_request_body.dart';
import 'models/login_request_body.dart';
import 'models/register_request_body.dart';
import 'models/reset_password_request_body.dart';
import 'models/token_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<TokenModel> login(
    @Body() LogInRequestBody logInRequestBody,
  );

  @POST(ApiConstants.register)
  Future<TokenModel> register(
    @Body() RegisterRequestBody registerRequestBody,
  );

  @POST(ApiConstants.googleSignIn)
  Future<TokenModel> googleSignIn(
    @Body() GoogleSignInRequestBody googleSignInRequestBody,
  );

  @POST(ApiConstants.forgotPassword)
  Future<TokenModel> forgotPassword(
    @Body() ForgotPasswordRequestBody forgotPasswordRequestBody,
  );

  @POST(ApiConstants.resetPassword)
  Future<TokenModel> resetPassword(
    @Body() ResetPasswordRequestBody resetPasswordRequestBody,
  );
}
