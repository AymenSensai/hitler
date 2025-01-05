class ContactEntity {
  final int? id;
  final String name;
  final String phoneNumber;
  final String contactType;

  ContactEntity({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.contactType,
  });
}
