import 'package:go_router/go_router.dart';
import 'package:knsbuy/screenns/dashboard/dashboard_main.dart';
import 'package:knsbuy/screenns/login/login_page.dart';
import 'package:knsbuy/screenns/packages/packages_page.dart';
import 'package:knsbuy/screenns/register/registration_page.dart';
import 'package:knsbuy/screenns/splash/splash_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String investment = '/dashboard/investment';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
      path: home,
      builder: (context, state) => const SplashScreen(), 
    ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
GoRoute(
        path: investment,
        builder: (context, state) => const InvestmentPage(),
      ),
    ],
  );
}
