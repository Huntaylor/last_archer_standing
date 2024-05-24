import 'package:go_router/go_router.dart';
import 'package:last_archer_standing/app/views/main_menu.dart';
import 'package:last_archer_standing/app/views/settings.dart';
import 'package:last_archer_standing/utils/routes/route_paths.dart';

final goRoutes = GoRouter(
  initialLocation: Paths.mainMenu.goRoute,
  routes: [
    GoRoute(
      path: Paths.mainMenu.goRoute,
      builder: (context, state) => const MainMenu(),
      routes: [
        GoRoute(
          path: Paths.mainMenu.settings.goRoute,
          builder: (context, state) => const Settings(),
        ),
      ],
    ),
  ],
);
