import 'package:stocks_app/features/contacts/data/remote/contacts_api_service.dart';
import 'package:stocks_app/features/contacts/data/remote/models/contact_model.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/repo/contacts_repo.dart';

class ContactsRepoImpl extends ContactsRepo {
  final ContactsApiService _apiService;

  ContactsRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<ContactEntity>>> getContacts() async {
    try {
      final response = await _apiService.getContacts();
      final entities = response.data.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<void>> addContact(ContactEntity contact) async {
    try {
      await _apiService.addContact(ContactModel.fromEntity(contact));
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
