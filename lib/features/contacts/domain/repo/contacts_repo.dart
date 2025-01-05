import '../../../../core/networking/api_result.dart';
import '../entities/contact_entity.dart';

abstract class ContactsRepo {
  Future<ApiResult<List<ContactEntity>>> getContacts();
  Future<ApiResult<void>> addContact(ContactEntity contact);
}
