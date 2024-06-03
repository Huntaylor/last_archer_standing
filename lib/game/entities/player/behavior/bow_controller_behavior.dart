// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';

class BowControllerBehavior extends Behavior<PlayerBow>
    with KeyboardHandler, HasGameRef<LastArcherStandingGame> {
  BowControllerBehavior();

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    parent.horizontalMovement = 0;
    parent.verticalMovement = 0;
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

    return super.onKeyEvent(event, keysPressed);
  }

  void stopPlayer() {
    parent.direction
      ..x = 0
      ..y = 0;
  }
}
