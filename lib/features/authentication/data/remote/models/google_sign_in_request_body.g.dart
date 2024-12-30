// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sign_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSignInRequestBody _$GoogleSignInRequestBodyFromJson(
        Map<String, dynamic> json) =>
    GoogleSignInRequestBody(
      idToken: json['id_token'] as String,
    );

Map<String, dynamic> _$GoogleSignInRequestBodyToJson(
        GoogleSignInRequestBody instance) =>
    <String, dynamic>{
      'id_token': instance.idToken,
    };
