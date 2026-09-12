import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/presentation/screens/course_detail_screen.dart';
import 'package:e_learner/presentation/screens/home_screen.dart';
import 'package:e_learner/presentation/screens/main_shell.dart';
import 'package:e_learner/presentation/screens/placeholder_tab_screen.dart';
import 'package:e_learner/presentation/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, _) => const WelcomeScreen()),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) => MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.home.routeName, builder: (_, _) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.search.routeName, builder: (_, _) => const PlaceholderTabScreen(title: StringConst.searchTab)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.myCourses.routeName, builder: (_, _) => const PlaceholderTabScreen(title: StringConst.myCoursesTab)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.profile.routeName, builder: (_, _) => const PlaceholderTabScreen(title: StringConst.profileTab)),
        ]),
      ],
    ),
    GoRoute(
      path: '${NamedRoutes.course.routeName}/:id',
      builder: (_, state) => CourseDetailScreen(courseId: state.pathParameters['id']!),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  search('/search'),
  myCourses('/my-courses'),
  profile('/profile'),
  course('/course');

  final String routeName;
  const NamedRoutes(this.routeName);
}
