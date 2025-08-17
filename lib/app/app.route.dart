import 'package:financy_app/app/page/screens/add_transaction/add_transaction.page.dart';
import 'package:financy_app/app/page/screens/home/home.page.dart';
import 'package:financy_app/app/page/screens/profile/profile.page.dart';
import 'package:financy_app/app/page/screens/stats/state.page.dart';
import 'package:financy_app/app/page/screens/transactions/transactions.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'page/auth/onBoarding/onboarding.page.dart';
import 'page/auth/register/register.page.dart';
import 'page/screens/app_scaffold/app_scaffold.page.dart';
import 'page/auth/login/login.page.dart';
import 'page/auth/splash/splash.page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: _redirectHandler,
  routes: [
    // Routes public
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => OnBoarding(),
    ),

    // Routes private
    GoRoute(
      path: '/app-scaffold',
      name: 'app-scaffold',
      builder: (context, state) => AppScaffoldPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/stats',
      name: 'stats',
      builder: (context, state) => StatsPage(),
    ),
    GoRoute(
      path: '/transactions',
      name: 'transactions',
      builder: (context, state) => TransactionsPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      name: 'addTransaction',
      path: '/add-transaction',
      builder: (context, state) => AddTransactionPage(),
    ),
  ],
);

Future<String?> _redirectHandler(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = FirebaseAuth.instance.currentUser != null;
  final location = state.uri.path;

  final publicRoutes = ['/login', '/register', '/onboarding'];
  if (location == '/') return null;

  if (!isAuthenticated && !publicRoutes.contains(location)) return '/login';
  if (isAuthenticated && publicRoutes.contains(location)) {
    return '/app-scaffold';
  }
  return null;
}
