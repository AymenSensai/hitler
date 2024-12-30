import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart';

@JsonSerializable()
class LogInRequestBody {
  final String email;
  final String password;

  const LogInRequestBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LogInRequestBodyToJson(this);
}
