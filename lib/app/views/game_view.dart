import 'package:flame/game.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameWidget<LastArcherStandingGame>.controlled(
        gameFactory: LastArcherStandingGame.new,
      ),
    );
  }
}
