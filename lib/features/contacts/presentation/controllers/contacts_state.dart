import 'package:stocks_app/features/contacts/domain/entities/contact_entity.dart';

sealed class ContactsState<T> {}

class ContactsInitial<T> extends ContactsState<T> {}

class GetContactsLoading<T> extends ContactsState<T> {}

class GetContactsSuccess<T> extends ContactsState<T> {
  final List<ContactEntity> contacts;
  GetContactsSuccess({required this.contacts});
}

class GetContactsError<T> extends ContactsState<T> {
  final String? error;
  GetContactsError({required this.error});
}

class AddContactLoading<T> extends ContactsState<T> {}

class AddContactSuccess<T> extends ContactsState<T> {}

class AddContactError<T> extends ContactsState<T> {
  final String? error;
  AddContactError({required this.error});
}
