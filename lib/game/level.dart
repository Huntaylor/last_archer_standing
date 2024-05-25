import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:logging/logging.dart';

class Level extends World with HasGameRef<LastArcherStandingGame> {
  static final Logger _log = Logger('Level Data');
  Level({
    // required this.player,
    super.children,
    super.priority,
  });
  // final Player player;

  late TiledComponent tiledLevel;

  @override
  FutureOr<void> onLoad() async {
    _log.info('Loading Level');
    tiledLevel = await TiledComponent.load(
      parse(TileMap.level1),
      Vector2.all(64),
    );

    _log.info(
        'tile size, Width: ${tiledLevel.width}, Height: ${tiledLevel.height}');

    await add(tiledLevel);

    return super.onLoad();
  }

  String parse(String data) {
    return data.replaceAll('assets/tiles/', '');
  }
}
