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
    final isKeyRepeat = event is KeyRepeatEvent;
    final isKeyDown = event is KeyDownEvent;
    late PlayerAnimationState playerState;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    parent.horizontalMovement += isLeftKeyPressed ? -1 : 0;
    parent.horizontalMovement += isRightKeyPressed ? 1 : 0;
    if (isLeftKeyPressed || isRightKeyPressed) {
      playerState = PlayerAnimationState.walking;
    } else {
      playerState = PlayerAnimationState.idle;
    }

    //     switch (event.logicalKey) {
    //       case LogicalKeyboardKey.keyA:
    //         playerState = PlayerAnimationState.walking;
    //         parent.direction..x += -1;
    //       case LogicalKeyboardKey.keyD:
    //         playerState = PlayerAnimationState.walking;
    //         parent.direction..x += 1;
    //       case LogicalKeyboardKey.keyS:
    //         playerState = PlayerAnimationState.walking;
    //         parent.direction..y += 1;
    //       case LogicalKeyboardKey.keyW:
    //         playerState = PlayerAnimationState.walking;
    //         parent.direction..y += -1;

    // } else {
    //     playerState = PlayerAnimationState.idle;
    //     parent.direction
    //       ..x = 0
    //       ..y = 0;
    //   }
    parent.stateBehavior.state = playerState;
    return super.onKeyEvent(event, keysPressed);
  }

  void stopPlayer() {
    parent.direction
      ..x = 0
      ..y = 0;
  }

  void getWalkingState() {
    parent.moveSpeed = 50;
  }
}
