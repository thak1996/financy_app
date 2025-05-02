import 'package:go_router/go_router.dart';
import 'page/auth/onBoarding/onboarding.page.dart';
import 'page/auth/register/register.page.dart';
import 'page/home/home.page.dart';
import 'page/auth/login/login.page.dart';
import 'page/auth/splash/splash.page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(path: '/onboarding', builder: (context, state) => OnBoarding()),
  ],
);
