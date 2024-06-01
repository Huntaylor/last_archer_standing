import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/game/player/player.dart';
import 'package:last_archer_standing/game/player/player_arrow.dart';
import 'package:last_archer_standing/game/player/player_bow.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/asset_parse.dart';
import 'package:logging/logging.dart';

class Level extends World
    with HasGameRef<LastArcherStandingGame>, AssetParse, TapCallbacks {
  static final Logger _log = Logger('Level Data');
  Level({
    required this.player,
    required this.bow,
    super.children,
    super.priority,
  });
  final Player player;
  final PlayerBow bow;

  late TiledComponent tiledLevel;

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
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    add(
      PlayerArrow(
        player.position,
        angle: bow.angle,
      ),
    );
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

            player.priority = 3;
            bow.priority = player.priority + 1;
            addAll([
              player,
              bow,
            ]);
          default:
        }
      }
    }
  }
}
