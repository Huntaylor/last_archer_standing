import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/entities/player/behavior/bow_behavior.dart';
import 'package:last_archer_standing/game/entities/player/behavior/bow_firing_behavior.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
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
          size: Vector2(69, 60),
          anchor: const Anchor(0.3, 0.5),
        );
  final Vector2 direction = Vector2.zero();
  double stepTime = 0.5;
  double walkingStepTime = 0.15;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  double moveSpeed = 200;
  Vector2 velocity = Vector2.zero();
  double horizontalMovement = 0;
  double verticalMovement = 0;

  final _upVector = Vector2(0, -1);

  late final BowStateBehavior stateBehavior = findBehavior<BowStateBehavior>();

  late final BowFiringBehavior firingBehavior =
      findBehavior<BowFiringBehavior>();

  @override
  FutureOr<void> onLoad() async {
    _log.info('Anchor Values: ${anchor.toVector2()}');
    _log.info('Located at X: $x and Y: $y');
    addAll(
      [
        BowStateBehavior(),
        BowFiringBehavior(),
      ],
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _getAngle();
      // _getMovement(fixedDeltaTime);
    }
    super.update(dt);
  }

  void _getAngle() {
    // DevKage used this calculation in one of his games, how does it work?
    final dir = game.mousePosition - position;
    angle = (-dir.angleToSigned(_upVector)) * scale.x.sign - (pi * 0.5);
  }

  void _getMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    velocity.y = verticalMovement * moveSpeed;

    position.y += velocity.y * dt;

    position.x += velocity.x * dt;

    accumulatedTime -= fixedDeltaTime;
  }
}
