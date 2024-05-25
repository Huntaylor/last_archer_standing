import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:last_archer_standing/game/level.dart';

class LastArcherStandingGame extends FlameGame
    with HasKeyboardHandlerComponents {
  LastArcherStandingGame();

  late Level level;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    level = Level();

    final viewfinder = Viewfinder();

    viewfinder.anchor = Anchor.topLeft;

    camera = CameraComponent.withFixedResolution(
      viewfinder: viewfinder,
      width: 1920,
      height: 1280,
      world: level,
    );

    // camera.follow(player);

    addAll(
      [
        camera,
        level,
      ],
    );
    return super.onLoad();
  }
}
