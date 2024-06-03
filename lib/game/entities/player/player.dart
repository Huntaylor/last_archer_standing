import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/entities/player/behavior/player_controller_behavior.dart';
import 'package:last_archer_standing/game/entities/player/behavior/player_state_behavior.dart';
import 'package:last_archer_standing/game/entities/player/player_arrow.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
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
  Vector2 velocity = Vector2.zero();
  double horizontalMovement = 0;
  double verticalMovement = 0;
  late PlayerAnimationState playerState;

  late PlayerArrow arrow;
  // late PlayerBow bow;

  late final PlayerStateBehavior stateBehavior =
      findBehavior<PlayerStateBehavior>();
  late final PlayerControllerBehavior controllerBehavior =
      findBehavior<PlayerControllerBehavior>();

  @override
  FutureOr<void> onLoad() {
    debugMode = true;

    playerState = PlayerAnimationState.idle;

    _log.info('Located at X: $x and Y: $y');

    // bow = PlayerBow(position: position)..anchor = anchor;

    // bow.scale = game.worldScale;

    addAll(
      [
        PlayerStateBehavior(),
        PlayerControllerBehavior(),
        // bow,
      ],
    );
    return super.onLoad();
  }

//   @override
//   void update(double dt) {
//     accumulatedTime += dt;

//     while (accumulatedTime >= fixedDeltaTime) {
//       velocity.x = horizontalMovement * moveSpeed;
//       velocity.y = verticalMovement * moveSpeed;

//       position.y += velocity.y * dt;

//       position.x += velocity.x * dt;

//       accumulatedTime -= fixedDeltaTime;
//     }
//     super.update(dt);
//   }
}
