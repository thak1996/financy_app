import 'package:financy_app/app/data/repositories/transaction.repository.dart';
import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:financy_app/app/shared/theme/theme_cubit.dart';
import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:financy_app/app/page/auth/login/login.controller.dart';
import 'package:financy_app/app/page/auth/register/register.controller.dart';
import 'package:financy_app/app/page/screens/add_transaction/add_transaction.controller.dart';
import 'package:financy_app/app/page/screens/app_scaffold/app_scaffold.controller.dart';
import 'package:financy_app/app/page/screens/home/home.controller.dart';
import 'package:financy_app/app/page/screens/profile/profile.controller.dart';
import 'package:financy_app/app/page/screens/stats/stats.controller.dart';
import 'package:financy_app/app/page/screens/transactions/transactions.controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
    BlocProvider<AppScaffoldController>(create: (_) => AppScaffoldController()),
    BlocProvider<LoginController>(
      create: (_) => LoginController(AuthFirebaseService(SecureStorage())),
    ),
    BlocProvider<RegisterController>(
      create: (_) => RegisterController(AuthFirebaseService(SecureStorage())),
    ),
    BlocProvider<StatsController>(create: (_) => StatsController()),
    BlocProvider<HomeController>(
      create: (_) => HomeController(TransactionRepositoryImpl()),
    ),
    BlocProvider<AddTransactionController>(
      create: (_) => AddTransactionController(),
    ),
    BlocProvider<TransactionsController>(
      create: (_) => TransactionsController(),
    ),
    BlocProvider<ProfileController>(
      create: (_) => ProfileController(AuthFirebaseService(SecureStorage())),
    ),
    Provider<TransactionRepository>(create: (_) => TransactionRepositoryImpl()),
    Provider<SecureStorage>(create: (_) => SecureStorage()),
  ];
}
