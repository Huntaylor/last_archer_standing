import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:last_archer_standing/resources/resources.dart';

void main() {
  test('tile_map assets test', () {
    expect(File(TileMap.level1).existsSync(), isTrue);
  });
}
