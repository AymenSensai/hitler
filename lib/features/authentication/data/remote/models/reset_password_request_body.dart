import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String email;
  final String password;
  final String passwordConfirmation;

  ResetPasswordRequestBody({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
