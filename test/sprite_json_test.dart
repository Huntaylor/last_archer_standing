import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:last_archer_standing/resources/resources.dart';

void main() {
  test('sprite_json assets test', () {
    expect(File(SpriteJson.playerArms).existsSync(), isTrue);
    expect(File(SpriteJson.playerBody).existsSync(), isTrue);
  });
}
