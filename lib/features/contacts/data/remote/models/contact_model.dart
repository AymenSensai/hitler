import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/contact_entity.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final int? id;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'contact_type')
  final String contactType;

  ContactModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.contactType,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);

  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      contactType: contactType,
    );
  }

  static ContactModel fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      contactType: entity.contactType,
    );
  }
}
