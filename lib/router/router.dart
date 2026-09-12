import 'package:e_learner/presentation/screens/home_screen.dart';
import 'package:e_learner/presentation/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, _) => const WelcomeScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (_, _) => const HomeScreen()),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home');

  final String routeName;
  const NamedRoutes(this.routeName);
}
