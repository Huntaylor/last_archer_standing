import 'package:last_archer_standing/utils/app_library.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: context.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Last Archer Standing',
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    context.push(Paths.mainMenu.gameView.path);
                  },
                  label: const Text('Tutorial'),
                  icon: const Icon(Icons.play_arrow),
                ),
                const SizedBox(
                  height: 8,
                ),
                // ElevatedButton.icon(
                //   iconAlignment: IconAlignment.end,
                //   onPressed: () {
                //     context.push(Paths.mainMenu.settings.path);
                //   },
                //   label: const Text('Settings'),
                //   icon: const Icon(Icons.settings),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
