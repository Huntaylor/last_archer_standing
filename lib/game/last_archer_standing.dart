import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:last_archer_standing/game/level.dart';
import 'package:last_archer_standing/game/player/player.dart';
import 'package:last_archer_standing/game/player/player_bow.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class LastArcherStandingGame extends FlameGame
    with HasKeyboardHandlerComponents {
  LastArcherStandingGame();

  PlayerBow bow = PlayerBow();
  Player player = Player();

  late Level level;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 180, 180, 180);

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    level = Level(
      player: player,
      bow: bow,
    );

    final viewfinder = Viewfinder();

    viewfinder.anchor = Anchor.topLeft;

    camera = CameraComponent.withFixedResolution(
      viewfinder: viewfinder,
      width: 1920,
      height: 1280,
      world: level,
    );

    addAll(
      [
        camera,
        level,
      ],
    );
    return super.onLoad();
  }
}
