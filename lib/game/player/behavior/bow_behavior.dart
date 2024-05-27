import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/game/player/player_bow.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/app_library.dart';

enum BowAnimationState {
  firing,
  idle,
}

class BowStateBehavior extends Behavior<PlayerBow>
    with HasGameRef<LastArcherStandingGame>, AssetParse {
  BowStateBehavior();
  BowAnimationState? _bowState;

  late final SpriteAnimationComponent firingAnimation;
  late final SpriteAnimationComponent idleAnimation;

  late final Map<BowAnimationState, PositionComponent> _stateMap;

  BowAnimationState get state => _bowState ?? BowAnimationState.idle;

  set state(BowAnimationState state) {
    if (state != _bowState) {
      final current = _stateMap[_bowState];

      if (current != null) {
        current.removeFromParent();

        if (current is SpriteAnimationComponent) {
          current.animationTicker?.reset();
        }
      }

      final replacement = _stateMap[state];
      if (replacement != null) {
        parent.add(replacement);
      }
      _bowState = state;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await _loadAllAnimations();
    await super.onLoad();

    // List of all animations
    _stateMap = {
      BowAnimationState.idle: idleAnimation,
      BowAnimationState.firing: firingAnimation,
    };

    // Set current animationdw
    state = BowAnimationState.idle;
  }

  Future<void> _loadAllAnimations() async {
    firingAnimation = await _spriteAnimation();
    idleAnimation = await _spriteAnimation();
  }

  Future<SpriteAnimationComponent> _spriteAnimation() async {
    final armPng = await game.images.load(
      imageParse(SpritePng.playerArms),
    );
    final armJson = await gameRef.assets.readJson(
      jsonPathParse(SpriteJson.playerArms),
    );

    return SpriteAnimationComponent(
      animation: SpriteAnimation.fromAsepriteData(
        armPng,
        armJson,
      ),
      anchor: Anchor.topLeft,
    );
  }
}
