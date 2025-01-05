import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocks_app/core/di/dependency_injection.dart';
import 'package:stocks_app/core/routing/app_router.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/features/history/presentation/controllers/history_cubit.dart';
import 'package:stocks_app/features/home/presentation/controllers/home_cubit.dart';
import 'package:stocks_app/features/settings/presentation/controllers/settings_cubit.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';
import '../utils/assets.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key, this.index});

  final int? index;

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  Widget _buildIcon(int index, String solidIcon, String regularIcon) {
    return SvgPicture.asset(
      _selectedIndex == index ? solidIcon : regularIcon,
      width: 24.w,
      height: 24.w,
      colorFilter: ColorFilter.mode(
        _selectedIndex == index ? ColorsManager.blue : ColorsManager.black,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return BlocProvider(
          create: (context) => getIt<HomeCubit>()..getDashboardData(),
          child: const HomeScreen(),
        );
      case 1:
        return BlocProvider.value(
          value: AppRouter.productsCubit
            ..getProducts()
            ..getCategories(),
          child: const ProductsScreen(),
        );
      case 2:
        return BlocProvider(
          create: (context) => getIt<HistoryCubit>()..getOrders(),
          child: const HistoryScreen(),
        );
      case 3:
        return BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
          child: const SettingsScreen(),
        );

      default:
        return const Text('No route defined for this tab');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(Routes.updateStock),
        child: Icon(
          Icons.shuffle,
          color: ColorsManager.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 70.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.blue,
          selectedLabelStyle: TextStyles.font10BlueRegular,
          unselectedLabelStyle: TextStyles.font10GreyRegular,
          unselectedItemColor: ColorsManager.black,
          backgroundColor: ColorsManager.white,
          iconSize: 24.w,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: _buildIcon(0, Assets.homeSolid, Assets.homeRegular),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child:
                    _buildIcon(1, Assets.productsSolid, Assets.productsRegular),
              ),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child:
                    _buildIcon(2, Assets.historySolid, Assets.historyRegular),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child:
                    _buildIcon(3, Assets.settingsSolid, Assets.settingsRegular),
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}
