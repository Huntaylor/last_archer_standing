import 'package:flame/components.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';

class PlayerArrow extends SpriteComponent
    with HasGameRef<LastArcherStandingGame> {
  PlayerArrow({
    super.position,
    super.priority,
    super.sprite,
    super.size,
  });
}
