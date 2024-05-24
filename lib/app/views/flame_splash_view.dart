import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class FlameSplashView extends StatelessWidget {
  const FlameSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme.white,
        showBefore: (context) {
          return Text(
            'Get Gaming Under Development',
            style: context.textTheme.titleLarge,
          );
        },
        onFinish: (context) => context.push(
          Paths.mainMenu.goRoute,
        ),
      ),
    );
  }
}
