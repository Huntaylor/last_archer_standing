import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:last_archer_standing/game/components/bow_loading_manager.dart';
import 'package:last_archer_standing/game/components/bow_timer_bar_component.dart';
import 'package:last_archer_standing/game/cubit/bow_cubit.dart';
import 'package:last_archer_standing/game/entities/player/player.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
import 'package:last_archer_standing/game/level.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class LastArcherStandingGame extends Forge2DGame
    with HasKeyboardHandlerComponents, MouseMovementDetector {
  LastArcherStandingGame({required this.bowCubit});

  final BowCubit bowCubit;

  PlayerBow bow = PlayerBow();
  Player player = Player();

  late Level level;
  late BowLoadingManager loadingManager;

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
  Color backgroundColor() => const Color.fromARGB(
        255,
        180,
        180,
        180,
      );

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    await _loadHud();
    await _loadLevel();

    return super.onLoad();
  }

  Future<void> _loadHud() async {
    loadingManager = BowLoadingManager(
      timerBar: InteractionTimerBar(),
      position: (player.position..y = player.position.y - 50),
    );
  }

  Future<void> _loadLevel() async {
    level = Level(
      player: player,
      bow: bow,
    );
    final viewfinder = Viewfinder();

    viewfinder
      ..anchor = Anchor.topLeft
      ..zoom = 3.5
      ..position = Vector2(0, 100);

    camera = CameraComponent(
      world: level,
      viewfinder: viewfinder,
      hudComponents: [
        loadingManager,
      ],
    );

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<BowCubit, BowState>.value(
            value: bowCubit,
            children: [
              level,
              camera,
            ],
          ),
        ],
      ),
    );
  }
}
