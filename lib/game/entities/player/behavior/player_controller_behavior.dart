// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';
import 'package:last_archer_standing/game/entities/player/behavior/player_state_behavior.dart';
import 'package:last_archer_standing/game/entities/player/player.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';

class PlayerControllerBehavior extends Behavior<Player>
    with KeyboardHandler, HasGameRef<LastArcherStandingGame> {
  PlayerControllerBehavior();

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    parent.horizontalMovement = 0;
    parent.verticalMovement = 0;
    late PlayerAnimationState playerState;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    parent.horizontalMovement += isLeftKeyPressed ? -1 : 0;
    parent.horizontalMovement += isRightKeyPressed ? 1 : 0;
    parent.verticalMovement += isUpKeyPressed ? -1 : 0;
    parent.verticalMovement += isDownKeyPressed ? 1 : 0;
    if (isLeftKeyPressed ||
        isRightKeyPressed ||
        isUpKeyPressed ||
        isDownKeyPressed) {
      playerState = PlayerAnimationState.walking;
    } else {
      playerState = PlayerAnimationState.idle;
    }

    parent.stateBehavior.state = playerState;
    return super.onKeyEvent(event, keysPressed);
  }

  void stopPlayer() {
    parent.direction
      ..x = 0
      ..y = 0;
  }
}
