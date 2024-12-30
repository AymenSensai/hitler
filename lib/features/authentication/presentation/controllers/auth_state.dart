sealed class AuthState<T> {}

class AuthInitial<T> extends AuthState<T> {}

class SignInLoading<T> extends AuthState<T> {}

class SignInSuccess<T> extends AuthState<T> {}

class SignInError<T> extends AuthState<T> {
  final String? error;

  SignInError({required this.error});
}

class SignUpLoading<T> extends AuthState<T> {}

class SignUpSuccess<T> extends AuthState<T> {}

class SignUpError<T> extends AuthState<T> {
  final String? error;

  SignUpError({required this.error});
}

class GoogleSignInLoading<T> extends AuthState<T> {}

class GoogleSignInSuccess<T> extends AuthState<T> {}

class GoogleSignInError<T> extends AuthState<T> {
  final String? error;

  GoogleSignInError({required this.error});
}

class ForgotPasswordLoading<T> extends AuthState<T> {}

class ForgotPasswordSuccess<T> extends AuthState<T> {}

class ForgotPasswordError<T> extends AuthState<T> {
  final String? error;

  ForgotPasswordError({required this.error});
}

class ResetPasswordLoading<T> extends AuthState<T> {}

class ResetPasswordSuccess<T> extends AuthState<T> {}

class ResetPasswordError<T> extends AuthState<T> {
  final String? error;

  ResetPasswordError({required this.error});
}
