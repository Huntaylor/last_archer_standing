import 'package:app_ui/app_ui.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:last_archer_standing/utils/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = FlexScheme.greenM3;
    return MaterialApp.router(
      routerConfig: goRoutes,
      theme: FlexThemeData.dark(
        scheme: theme,
        textTheme: LastArcherStandingTheme.standard.textTheme,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: theme,
        textTheme: LastArcherStandingTheme.large.textTheme,
      ),
    );
  }
}
