import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:last_archer_standing/game/components/bow_timer_bar_component.dart';
import 'package:last_archer_standing/game/components/target_component.dart';
import 'package:last_archer_standing/game/cubit/bow_cubit.dart';
import 'package:last_archer_standing/game/entities/player/player.dart';
import 'package:last_archer_standing/game/entities/player/player_arrow.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/asset_parse.dart';
import 'package:logging/logging.dart';

class Level extends World
    with
        HasGameRef<LastArcherStandingGame>,
        AssetParse,
        TapCallbacks,
        FlameBlocListenable<BowCubit, BowState> {
  static final Logger _log = Logger('Level Data');
  Level({
    required this.player,
    required this.bow,
    // required this.target,
    super.children,
    super.priority,
  });
  final Player player;
  final PlayerBow bow;
  // final TargetComponent target;

  late TiledComponent tiledLevel;
  late PlayerArrow playerArrow;
  bool canFire = true;

  List<PlayerArrow> quiver = [];

  @override
  bool listenWhen(BowState previousState, BowState newState) {
    _log.info('State Changes');
    if (newState.asInitial.hasFired) {
      canFire = false;
      bow.firingBehavior.getFiringState();
    }
    if (newState.asInitial.timerState == TimerState.complete) {
      bow.firingBehavior.getIdleState();
      Future.delayed(const Duration(milliseconds: 300), () {
        canFire = true;
      });
    }
    return super.listenWhen(previousState, newState);
  }

  @override
  FutureOr<void> onLoad() async {
    _log.info('Loading Level');

    tiledLevel = await TiledComponent.load(
      tilesParse(TileMap.level1),
      Vector2.all(64),
    )
      ..scale = game.worldScale;

    _log.info(
      'tile size, Width: ${tiledLevel.width}, Height: ${tiledLevel.height}',
    );

    await add(tiledLevel);
    await _spawningObjects(tiledLevel);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (quiver.isNotEmpty) {
      for (var i = 0; i < quiver.length; ++i) {
        if (!game.camera.visibleWorldRect
            .contains(quiver[i].position.toOffset())) {
          _log.info('Arrow has been removed');
          quiver[i].removeFromParent();
          quiver.removeAt(i);
        }
      }
    }
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    super.onTapDown(event);

    if (canFire) {
      game.bowCubit.arrowFired(hasFired: true);

      playerArrow = PlayerArrow(
        player.position,
        angle: bow.angle,
      );
      await add(
        playerArrow,
      );

      quiver.add(playerArrow);
    }
  }

  Future<void> _spawningObjects(
    TiledComponent<FlameGame<World>> tiledLevel,
  ) async {
    final spawnPointLayer =
        tiledLevel.tileMap.getLayer<ObjectGroup>('Spawn_Point');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        final positionPlayer = Vector2(175, 225);
        switch (spawnPoint.class_) {
          case 'Player_Spawn':
            _log.info(
              'Spawning Player at ${spawnPoint.x} - X and ${spawnPoint.y} - Y',
            );
            bow
              ..position = positionPlayer
              ..scale = game
                  .worldScale; /* Vector2(
              spawnPoint.x,
              spawnPoint.y,
            ); */
            player
              ..position = positionPlayer
              ..scale = game
                  .worldScale; /* Vector2(
              spawnPoint.x,
              spawnPoint.y,
            ); */
            // target.position = Vector2(250, 225);
            player.priority = 3;
            bow.priority = player.priority + 1;
            addAll([
              player,
              bow,
              // target,
            ]);
          default:
        }
      }
      final target = TargetComponent(
        scale: game.worldScale,
        position: Vector2(250, 225),
      );

      add(target);
    }
  }
}
