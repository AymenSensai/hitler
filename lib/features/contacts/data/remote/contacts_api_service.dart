import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stocks_app/features/contacts/data/remote/models/contact_model.dart';
import 'package:stocks_app/features/contacts/data/remote/models/contacts_response.dart';

import '../../../../core/networking/api_constants.dart';

part 'contacts_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ContactsApiService {
  factory ContactsApiService(Dio dio, {String baseUrl}) = _ContactsApiService;

  @GET(ApiConstants.contacts)
  Future<ContactsResponse> getContacts();

  @POST(ApiConstants.contacts)
  Future<void> addContact(
    @Body() ContactModel contact,
  );
}
