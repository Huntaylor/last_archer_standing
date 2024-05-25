import 'package:go_router/go_router.dart';
import 'package:last_archer_standing/app/views/flame_splash_view.dart';
import 'package:last_archer_standing/app/views/game_view.dart';
import 'package:last_archer_standing/app/views/main_menu.dart';
import 'package:last_archer_standing/app/views/settings.dart';
import 'package:last_archer_standing/utils/routes/route_paths.dart';

final goRoutes = GoRouter(
  initialLocation: Paths.initial.goRoute,
  routes: [
    GoRoute(
      path: Paths.initial.goRoute,
      builder: (context, state) => const FlameSplashView(),
    ),
    GoRoute(
      path: Paths.mainMenu.goRoute,
      builder: (context, state) => const MainMenu(),
      routes: [
        GoRoute(
          path: Paths.mainMenu.settings.goRoute,
          builder: (context, state) => const Settings(),
        ),
        GoRoute(
          path: Paths.mainMenu.gameView.goRoute,
          builder: (context, state) => const GameView(),
        ),
      ],
    ),
  ],
);
