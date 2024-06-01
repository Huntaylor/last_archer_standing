import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:last_archer_standing/game/level.dart';
import 'package:last_archer_standing/game/entities/player/player.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class LastArcherStandingGame extends Forge2DGame
    with HasKeyboardHandlerComponents, MouseMovementDetector {
  LastArcherStandingGame();

  PlayerBow bow = PlayerBow();
  Player player = Player();

  late Level level;

  final Vector2 worldScale = Vector2.all(0.3);

  final Vector2 mousePosition = Vector2.zero();
  final arrowVector = Vector2.zero();

  @override
  void onMouseMove(PointerHoverInfo info) {
    mousePosition.setFrom(camera.globalToLocal(info.eventPosition.global));
    arrowVector.setFrom(info.eventPosition.global);
    super.onMouseMove(info);
  }

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

    viewfinder
      ..anchor = Anchor.topLeft
      ..zoom = 3
      ..position = Vector2(0, 100);
    // viewfinder
    //   ..anchor = Anchor.topLeft
    //   ..zoom = 3
    //   ..position = Vector2(500, 800);

    // camera = CameraComponent.withFixedResolution(
    //   viewfinder: viewfinder,
    //   width: 1920,
    //   height: 1280,
    //   world: level,
    // );

    camera = CameraComponent(
      world: level,
      viewfinder: viewfinder,
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
