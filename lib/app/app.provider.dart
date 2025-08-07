import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/exports.dart';
import 'page/exports.dart';

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
    BlocProvider<HomeController>(create: (_) => HomeController()),
    BlocProvider<AddTransactionController>(
      create: (_) => AddTransactionController(),
    ),
    BlocProvider<TransactionsController>(
      create: (_) => TransactionsController(),
    ),
    BlocProvider<ProfileController>(
      create: (_) => ProfileController(AuthFirebaseService(SecureStorage())),
    ),
    Provider<SecureStorage>(create: (_) => SecureStorage()),
  ];
}
