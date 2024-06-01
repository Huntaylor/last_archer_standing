import 'dart:math';

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
    Vector2? size,
    super.bodyDef,
    super.priority,
  }) : size = size ?? Vector2(44, 6);

  @override
  late double angle;

  final Vector2 initialPosition;
  final Vector2 size;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final spriteImage = await game.images.load(imageParse(SpritePng.arrow));

    renderBody = false;
    debugMode = true;

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
  void update(double dt) {
    super.update(dt);
    const dragConstant = 0.1;
    //  const double speed = 10.0;
    // final velocity = Vector2(cos(angle), sin(angle)) * speed;

    final flightDirection = body.linearVelocity;
    final flightSpeed = flightDirection.length;
    final pointingDirection = body.worldVector(Vector2(1, 0));
    final dot = dot2(flightDirection, pointingDirection);

    final dragForceMagnitude =
        1 - dot.abs() * flightSpeed * flightSpeed * dragConstant * body.mass;

    final arrowTailPosition = body.worldPoint(Vector2(-1.4, 0));

    final dragForce = flightDirection * -dragForceMagnitude;

    body.applyForce(
      dragForce,
      point: arrowTailPosition,
    );
  }

  @override
  Body createBody() {
    size.scale(0.3);
    final shape = PolygonShape();

    final vertices = [
      Vector2(-1.4, 0),
      Vector2(0, -0.1),
      Vector2(0.6, 0),
      Vector2(0, 0.1),
      // Vector2(-size.x / 2, size.y / 2),
      // Vector2(size.x / 2, size.y / 2),
      // Vector2(size.x / 2, -size.y / 2),
      // Vector2(-size.x / 2, -size.y / 2),
    ];

    _log.info('Arrow Vertices: $vertices, Length: ${vertices.length}');

    shape.set(vertices);

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.4,
    );
    const double speed = 10.0;
    final velocity = Vector2(cos(angle), sin(angle)) * speed;

    final bodyDef = BodyDef(
      bullet: true,
      angularVelocity: -0.5,
      position: initialPosition,
      angle: angle,
      linearVelocity: velocity,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
