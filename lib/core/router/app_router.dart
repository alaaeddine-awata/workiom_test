import 'package:go_router/go_router.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/signin_method_page.dart';
import '../../presentation/pages/workspace_page.dart';
import '../../presentation/pages/success_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String signinMethod = '/signin-method';
  static const String login = '/login';
  static const String workspace = '/workspace';
  static const String success = '/success';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: signinMethod,
        name: 'signin-method',
        builder: (context, state) => const SigninMethodPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: workspace,
        name: 'workspace',
        builder: (context, state) => const WorkspacePage(),
      ),
      GoRoute(
        path: success,
        name: 'success',
        builder: (context, state) => const SuccessPage(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
