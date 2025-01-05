import 'package:json_annotation/json_annotation.dart';

import 'contact_model.dart';

part 'contacts_response.g.dart';

@JsonSerializable()
class ContactsResponse {
  final String message;
  final List<ContactModel> data;

  ContactsResponse({
    required this.message,
    required this.data,
  });

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}
