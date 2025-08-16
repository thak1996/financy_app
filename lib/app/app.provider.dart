import 'package:financy_app/app/data/repositories/transaction.repository.dart';
import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:financy_app/app/data/services/graohql.service.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    // -------------------- Core utilities --------------------
    // Secure storage singleton used across the app
    Provider<SecureStorage>(create: (_) => SecureStorage()),

    // -------------------- Services --------------------
    // Auth service depends on SecureStorage
    Provider<AuthFirebaseService>(
      create: (context) {
        return AuthFirebaseService(
          secureStorageService: context.read<SecureStorage>(),
        );
      },
    ),

    // GraphQL service depends on Auth service
    Provider<GraphQlService>(
      create: (context) {
        return GraphQlService(authService: context.read<AuthFirebaseService>());
      },
    ),

    // -------------------- Repositories --------------------
    Provider<TransactionRepository>(create: (_) => TransactionRepositoryImpl()),

    // -------------------- Blocs / Cubits --------------------
    // ThemeCubit uses the same SecureStorage instance
    BlocProvider<ThemeCubit>(
      create: (context) {
        return ThemeCubit(storage: context.read<FlutterSecureStorage>());
      },
    ),

    // App-level scaffold controller
    BlocProvider<AppScaffoldController>(create: (_) => AppScaffoldController()),

    // -------------------- Feature Controllers --------------------
    BlocProvider<LoginController>(
      create: (context) {
        return LoginController(
          authService: context.read<AuthFirebaseService>(),
        );
      },
    ),

    BlocProvider<RegisterController>(
      create: (context) {
        return RegisterController(
          graphQlService: context.read<GraphQlService>(),
          authService: context.read<AuthFirebaseService>(),
        );
      },
    ),

    BlocProvider<StatsController>(create: (_) => StatsController()),

    BlocProvider<HomeController>(
      create: (context) {
        return HomeController(context.read<TransactionRepository>());
      },
    ),

    BlocProvider<AddTransactionController>(
      create: (_) => AddTransactionController(),
    ),

    BlocProvider<TransactionsController>(
      create: (_) => TransactionsController(),
    ),

    BlocProvider<ProfileController>(
      create: (context) {
        return ProfileController(context.read<AuthFirebaseService>());
      },
    ),
  ];
}
