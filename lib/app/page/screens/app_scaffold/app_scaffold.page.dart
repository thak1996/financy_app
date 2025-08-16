import 'package:financy_app/app/data/repositories/transaction.repository.dart';
import 'package:financy_app/app/shared/consts/keys.dart';
import 'package:financy_app/app/shared/extensions/page_controller.ext.dart';
import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
import 'package:financy_app/app/page/screens/app_scaffold/app_scaffold.controller.dart';
import 'package:financy_app/app/page/screens/app_scaffold/app_scaffold.state.dart';
import 'package:financy_app/app/page/screens/home/home.controller.dart';
import 'package:financy_app/app/page/screens/home/home.page.dart';
import 'package:financy_app/app/page/screens/profile/profile.controller.dart';
import 'package:financy_app/app/page/screens/profile/profile.page.dart';
import 'package:financy_app/app/page/screens/stats/state.page.dart';
import 'package:financy_app/app/page/screens/stats/stats.controller.dart';
import 'package:financy_app/app/page/screens/transactions/transactions.controller.dart';
import 'package:financy_app/app/page/screens/transactions/transactions.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/single_child_widget.dart';

class AppScaffoldPage extends StatelessWidget {
  const AppScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createProviders(),
      child: BlocBuilder<AppScaffoldController, AppScaffoldState>(
        builder: (context, state) {
          final controller = context.read<AppScaffoldController>();
          controller.pageController.setBottomAppBarItemIndex = 0;
          return BlocListener<AppScaffoldController, AppScaffoldState>(
            listener: (context, state) {
              if (state is AppScaffoldError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: [
                  HomePage(),
                  StatsPage(),
                  TransactionsPage(),
                  ProfilePage(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final result = await context.pushNamed('addTransaction');
                  if (result != null && context.mounted) {
                    _refreshPage(context, controller);
                  }
                },
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBarWidget(
                controller: controller.pageController,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                children: [
                  CustomBottomAppBarItem(
                    key: Keys.homePageBottomAppBarItem,
                    label: BottomAppBarItem.home.name,
                    primaryIcon: Icons.home,
                    secondaryIcon: Icons.home_outlined,
                    onPressed:
                        () => controller.pageController.navigateTo(
                          BottomAppBarItem.home,
                        ),
                  ),
                  CustomBottomAppBarItem(
                    key: Keys.statsPageBottomAppBarItem,
                    label: BottomAppBarItem.stats.name,
                    primaryIcon: Icons.analytics,
                    secondaryIcon: Icons.analytics_outlined,
                    onPressed:
                        () => controller.pageController.navigateTo(
                          BottomAppBarItem.stats,
                        ),
                  ),
                  CustomBottomAppBarItem.empty(),
                  CustomBottomAppBarItem(
                    key: Keys.walletPageBottomAppBarItem,
                    label: BottomAppBarItem.wallet.name,
                    primaryIcon: Icons.account_balance_wallet,
                    secondaryIcon: Icons.account_balance_wallet_outlined,
                    onPressed:
                        () => controller.pageController.navigateTo(
                          BottomAppBarItem.wallet,
                        ),
                  ),
                  CustomBottomAppBarItem(
                    key: Keys.profilePageBottomAppBarItem,
                    label: BottomAppBarItem.profile.name,
                    primaryIcon: Icons.person,
                    secondaryIcon: Icons.person_outline,
                    onPressed:
                        () => controller.pageController.navigateTo(
                          BottomAppBarItem.profile,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<SingleChildWidget> _createProviders() {
    return [
      BlocProvider(
        create:
            (context) => AppScaffoldController()..setPage = PageController(),
      ),
      BlocProvider(
        create:
            (context) =>
                HomeController(TransactionRepositoryImpl())..loadHomeData(),
      ),
      BlocProvider(create: (context) => StatsController()..loadStatsData()),
      BlocProvider(
        create: (context) => TransactionsController()..loadTransactionsData(),
      ),
      BlocProvider(
        create:
            (context) => ProfileController(
              AuthFirebaseService(secureStorageService: SecureStorage()),
            )..loadProfileData(),
      ),
    ];
  }

  Future<void> _refreshPage(
    BuildContext context,
    AppScaffoldController controller,
  ) async {
    final currentPage = controller.pageController.page?.round() ?? 0;
    switch (currentPage) {
      case 0:
        await context.read<HomeController>().refreshData();
        break;
      case 1:
        await context.read<StatsController>().refreshData();
        break;
      case 2:
        await context.read<TransactionsController>().refreshData();
        break;
      case 3:
        await context.read<ProfileController>().refreshData();
        break;
    }
  }
}
