import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contact_entity.dart';
import '../../domain/repo/contacts_repo.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit(this._contactsRepo) : super(ContactsInitial());

  final ContactsRepo _contactsRepo;

  Future<void> getContacts() async {
    emit(GetContactsLoading());
    final response = await _contactsRepo.getContacts();
    response.when(
      success: (response) {
        emit(GetContactsSuccess(contacts: response));
      },
      failure: (error) {
        emit(GetContactsError(error: error));
      },
    );
  }

  Future<void> addContact(ContactEntity contact) async {
    emit(AddContactLoading());
    final response = await _contactsRepo.addContact(contact);
    response.when(
      success: (response) {
        emit(AddContactSuccess());
      },
      failure: (error) {
        emit(AddContactError(error: error));
      },
    );
  }
}
