import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/entities/player/behavior/player_controller_behavior.dart';
import 'package:last_archer_standing/game/entities/player/behavior/player_state_behavior.dart';
import 'package:last_archer_standing/game/entities/player/player_arrow.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
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
          anchor: const Anchor(0.35, 0.35),
        );

  final Vector2 direction = Vector2.zero();

  double stepTime = 0.5;
  double walkingStepTime = 0.15;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  double moveSpeed = 200;
  double horizontalMovement = 0;
  double verticalMovement = 0;
  late PlayerAnimationState playerState;

  late PlayerArrow arrow;
  // final _upVector = Vector2(0, -1);

  late final PlayerStateBehavior stateBehavior =
      findBehavior<PlayerStateBehavior>();
  late final PlayerControllerBehavior controllerBehavior =
      findBehavior<PlayerControllerBehavior>();

  @override
  FutureOr<void> onLoad() {
    debugMode = true;

    playerState = PlayerAnimationState.idle;

    _log.info('Located at X: $x and Y: $y');

    addAll(
      [
        PlayerStateBehavior(),
        PlayerControllerBehavior(),
      ],
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final displacement = direction.normalized() * moveSpeed * dt;

    position.add(displacement);
    super.update(dt);
  }
}
