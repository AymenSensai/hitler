// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInRequestBody _$LogInRequestBodyFromJson(Map<String, dynamic> json) =>
    LogInRequestBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LogInRequestBodyToJson(LogInRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
