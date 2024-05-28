import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/game/player/player.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/app_library.dart';
import 'package:logging/logging.dart';

enum PlayerAnimationState {
  waling,
  idle,
}

class PlayerStateBehavior extends Behavior<Player>
    with HasGameRef<LastArcherStandingGame>, AssetParse {
  static final Logger _log = Logger('Player Behavior Data');
  PlayerStateBehavior();
  PlayerAnimationState? _playerState;

  late final SpriteAnimationComponent walkingAnimation;
  late final SpriteAnimationComponent idleAnimation;

  late final Map<PlayerAnimationState, PositionComponent> _stateMap;

  PlayerAnimationState get state => _playerState ?? PlayerAnimationState.idle;

  set state(PlayerAnimationState state) {
    if (state != _playerState) {
      final current = _stateMap[_playerState];

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
      _playerState = state;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await _loadAllAnimations();
    await super.onLoad();
  }

  Future<void> _loadAllAnimations() async {
    _log.info('Loading all animations');
    walkingAnimation = await _spriteAnimation();
    idleAnimation = await _spriteAnimation();

    // List of all animations
    _stateMap = {
      PlayerAnimationState.idle: idleAnimation,
      PlayerAnimationState.waling: walkingAnimation,
    };

    // Set current animationdw
    state = PlayerAnimationState.idle;
  }

  Future<SpriteAnimationComponent> _spriteAnimation() async {
    final bodyPng = await game.images.load(
      imageParse(SpritePng.playerBody),
    );
    final bodyJson = await gameRef.assets.readJson(
      jsonPathParse(SpriteJson.playerBody),
    );

    return SpriteAnimationComponent(
      animation: SpriteAnimation.fromAsepriteData(
        bodyPng,
        bodyJson,
      ),
    );
  }
}
