import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:last_archer_standing/resources/resources.dart';
import 'package:last_archer_standing/utils/app_library.dart';
import 'package:logging/logging.dart';

class PlayerArrow extends BodyComponent<LastArcherStandingGame>
    with AssetParse {
  static final Logger _log = Logger('Arrow Data');
  PlayerArrow(
    this.initialPosition, {
    required this.angle,
    required this.linearVelocity,
    Vector2? size,
    super.bodyDef,
    super.priority,
  }) : size = size ?? Vector2(44, 6);

  @override
  late double angle;

  final Vector2 linearVelocity;
  final Vector2 initialPosition;
  final Vector2 size;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final spriteImage = await game.images.load(imageParse(SpritePng.arrow));

    renderBody = false;

    // body.applyLinearImpulse(linearVelocity);
    add(
      SpriteComponent.fromImage(
        spriteImage,
        size: size,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    size.scale(0.3);
    final shape = PolygonShape();

    final vertices = [
      Vector2(-size.x / 2, size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(-size.x / 2, -size.y / 2),
    ];

    _log.info('Arrow Vertices: $vertices, Length: ${vertices.length}');

    shape.set(vertices);

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.4,
    );

    final bodyDef = BodyDef(
      bullet: true,
      angularVelocity: -0.5,
      // linearVelocity: Vector2(1, 1),
      linearVelocity: game.arrowVector,
      position: initialPosition,
      angle: angle,
      // angle: (initialPosition.x + initialPosition.y) / 2 * pi,

      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
