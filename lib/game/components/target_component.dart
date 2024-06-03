import 'dart:async';

import 'package:flame/components.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/asset_parse.dart';

class TargetComponent extends SpriteComponent
    with HasGameRef<LastArcherStandingGame>, AssetParse {
  TargetComponent({
    super.sprite,
    super.scale,
    super.anchor,
    super.position,
    super.priority,
  }) : super(size: Vector2.all(64));

  @override
  FutureOr<void> onLoad() async {
    final targetPath = await game.images.load(imageParse(SpritePng.target));
    sprite = Sprite(targetPath);

    return super.onLoad();
  }
}
