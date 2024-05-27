import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/game/player/behavior/player_behavior.dart';
import 'package:logging/logging.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<LastArcherStandingGame>, EntityMixin {
  static final Logger _log = Logger('Player Data');
  Player({
    super.position,
    super.priority,
    super.current,
    super.animations,
    super.children,
  }) : super(
          size: Vector2(69, 117),
          anchor: Anchor.topLeft,
        );

  late PlayerAnimationState playerState;

  late final PlayerStateBehavior stateBehavior =
      findBehavior<PlayerStateBehavior>();

  @override
  FutureOr<void> onLoad() {
    playerState = PlayerAnimationState.idle;

    _log.info('Located at X: $x and Y: $y');

    addAll([PlayerStateBehavior()]);
    return super.onLoad();
  }
}