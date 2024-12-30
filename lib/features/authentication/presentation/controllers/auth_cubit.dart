import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/dio_factory.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_pref_helper.dart';
import '../../domain/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());

  final AuthRepo _authRepo;

  Future<void> login(String email, String password) async {
    emit(SignInLoading());
    final response = await _authRepo.login(email, password);
    response.when(
      success: (response) async {
        await _saveUserToken(response.token);
        emit(SignInSuccess());
      },
      failure: (error) {
        emit(SignInError(error: error));
      },
    );
  }

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    emit(SignUpLoading());
    final response = await _authRepo.register(
      name,
      email,
      password,
    );
    response.when(
      success: (response) async {
        await _saveUserToken(response.token);
        emit(SignUpSuccess());
      },
      failure: (error) {
        emit(SignUpError(error: error));
      },
    );
  }

  Future<void> googleSignIn(String idToken) async {
    emit(GoogleSignInLoading());
    final response = await _authRepo.googleSignIn(idToken);
    response.when(
      success: (response) async {
        await _saveUserToken(response.token);
        emit(GoogleSignInSuccess());
      },
      failure: (error) {
        emit(GoogleSignInError(error: error));
      },
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    final response = await _authRepo.forgotPassword(email);
    response.when(
      success: (response) async {
        await _saveUserToken(response.token);
        emit(ForgotPasswordSuccess());
      },
      failure: (error) {
        emit(ForgotPasswordError(error: error));
      },
    );
  }

  Future<void> resetPassword(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    emit(ResetPasswordLoading());
    final response = await _authRepo.resetPassword(
      email,
      password,
      passwordConfirmation,
    );
    response.when(
      success: (response) async {
        await _saveUserToken(response.token);
        emit(ResetPasswordSuccess());
      },
      failure: (error) {
        emit(ResetPasswordError(error: error));
      },
    );
  }

  Future<void> _saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
