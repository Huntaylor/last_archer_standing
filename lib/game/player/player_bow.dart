import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/game/player/behavior/bow_behavior.dart';
import 'package:logging/logging.dart';

class PlayerBow extends SpriteAnimationGroupComponent<BowAnimationState>
    with HasGameRef<LastArcherStandingGame>, EntityMixin {
  static final Logger _log = Logger('PlayerBow Data');
  PlayerBow({
    super.position,
    super.priority,
    super.current,
    super.animations,
  }) : super(
          size: Vector2(69, 117),
          anchor: Anchor.topLeft,
        );

  late BowAnimationState bowState;

  late final BowStateBehavior stateBehavior = findBehavior<BowStateBehavior>();

  @override
  FutureOr<void> onLoad() async {
    _log.info('Located at X: $x and Y: $y');
    bowState = BowAnimationState.idle;
    add(BowStateBehavior());
    return super.onLoad();
  }
}
