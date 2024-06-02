import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/entities/player/behavior/bow_behavior.dart';
import 'package:last_archer_standing/game/entities/player/player_bow.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/utils/app_library.dart';

class BowFiringBehavior extends Behavior<PlayerBow>
    with HasGameRef<LastArcherStandingGame>, AssetParse {
  BowFiringBehavior();

  void getFiringState() {
    parent.stateBehavior.state = BowAnimationState.firing;
  }

  void getIdleState() {
    parent.stateBehavior.state = BowAnimationState.idle;
  }
}
