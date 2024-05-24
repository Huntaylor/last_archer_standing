import 'package:go_router_paths/go_router_paths.dart';

class Paths {
  const Paths._();

  static Path get initial => Path('');
  static MainMenuPath get mainMenu => MainMenuPath();
}

class MainMenuPath extends Path {
  MainMenuPath() : super('main_menu');

  Path get settings => Path(
        'settings',
        parent: this,
      );
  Path get gameView => Path(
        'gameView',
        parent: this,
      );
}
