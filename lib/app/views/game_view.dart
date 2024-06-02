import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_archer_standing/game/cubit/bow_cubit.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final bowCubit = context.read<BowCubit>();
    return Scaffold(
      body: GameWidget<LastArcherStandingGame>.controlled(
        gameFactory: () => LastArcherStandingGame(
          bowCubit: bowCubit,
        ),
      ),
    );
  }
}
