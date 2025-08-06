import 'package:financy_app/app/core/utils/secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../page/auth/onBoarding/onboarding.page.dart';
import '../../page/auth/register/register.page.dart';
import '../../page/home/home.page.dart';
import '../../page/auth/login/login.page.dart';
import '../../page/auth/splash/splash.page.dart';

final SecureStorage secureStorage = SecureStorage();

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
      path: '/home',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
  ],
);

Future<String?> _redirectHandler(
  BuildContext context,
  GoRouterState state,
) async {
  final token = await secureStorage.read('user');
  final isAuthenticated = token != null && token.isNotEmpty;
  final location = state.uri.path;

  final publicRoutes = ['/login', '/register', '/onboarding'];
  if (location == '/') return null;

  if (!isAuthenticated && !publicRoutes.contains(location)) return '/login';
  if (isAuthenticated && publicRoutes.contains(location)) return '/home';

  return null;
}
