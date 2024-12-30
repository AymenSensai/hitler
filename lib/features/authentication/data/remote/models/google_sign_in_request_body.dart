import 'package:json_annotation/json_annotation.dart';

part 'google_sign_in_request_body.g.dart';

@JsonSerializable()
class GoogleSignInRequestBody {
  @JsonKey(name: 'id_token')
  final String idToken;

  GoogleSignInRequestBody({
    required this.idToken,
  });

  Map<String, dynamic> toJson() => _$GoogleSignInRequestBodyToJson(this);
}
