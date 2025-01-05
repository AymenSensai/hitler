import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/contacts/presentation/controllers/contacts_cubit.dart';
import 'package:stocks_app/features/contacts/presentation/widgets/contacts_bloc_listener.dart';

import '../../../../core/widgets/app_text_form_field.dart';
import '../../domain/entities/contact_entity.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _contactType = 'Customer';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _saveContact() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ContactsCubit>().addContact(
            ContactEntity(
              name: _nameController.text,
              phoneNumber: _phoneController.text,
              contactType: _contactType,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Create Contact',
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Name',
                    style: TextStyles.font16BlackMedium,
                  ),
                  verticalSpace(16),
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a contact name.';
                      }
                      return null;
                    },
                    controller: _nameController,
                    hintText: 'Contact Name',
                  ),
                  verticalSpace(24),
                  Text(
                    'Phone Number',
                    style: TextStyles.font16BlackMedium,
                  ),
                  verticalSpace(16),
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number.';
                      } else if (!RegExp(r'^\+?[0-9]{10,13}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid phone number.';
                      }
                      return null;
                    },
                    controller: _phoneController,
                    hintText: 'Phone Number',
                  ),
                  verticalSpace(24),
                  Text(
                    'Contact Type',
                    style: TextStyles.font16BlackMedium,
                  ),
                  verticalSpace(8),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Customer',
                        groupValue: _contactType,
                        onChanged: (value) {
                          setState(() {
                            _contactType = value!;
                          });
                        },
                      ),
                      Text(
                        'Customer',
                        style: TextStyles.font16BlackRegular,
                      ),
                      horizontalSpace(16),
                      Radio<String>(
                        value: 'Vendor',
                        groupValue: _contactType,
                        onChanged: (value) {
                          setState(() {
                            _contactType = value!;
                          });
                        },
                      ),
                      Text(
                        'Vendor',
                        style: TextStyles.font16BlackRegular,
                      ),
                    ],
                  ),
                  ContactsBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
