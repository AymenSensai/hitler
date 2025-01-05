import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/products/domain/entities/category_entity.dart';
import 'package:stocks_app/features/settings/presentation/controllers/settings_state.dart';

import '../../domain/repo/settings_repo.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepo) : super(SettingsInitial());

  final SettingsRepo _settingsRepo;
  final List<CategoryEntity> categories = [];

  Future<void> getCategories() async {
    final response = await _settingsRepo.getCategories();
    response.when(
      success: (response) {
        categories.clear();
        categories.addAll(response);
      },
      failure: (error) {},
    );
  }
}
