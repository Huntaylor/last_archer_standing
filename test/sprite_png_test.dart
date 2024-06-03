import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:last_archer_standing/resources/resources.dart';

void main() {
  test('sprite_png assets test', () {
    expect(File(SpritePng.arrow).existsSync(), isTrue);
    expect(File(SpritePng.bowDrawback).existsSync(), isTrue);
    expect(File(SpritePng.bowRelease).existsSync(), isTrue);
    expect(File(SpritePng.playerArms).existsSync(), isTrue);
    expect(File(SpritePng.playerBody).existsSync(), isTrue);
    expect(File(SpritePng.playerIdle).existsSync(), isTrue);
    expect(File(SpritePng.target).existsSync(), isTrue);
  });
}
