import 'package:last_archer_standing/utils/app_library.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                  'Settings',
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                const AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Icon(Icons.music_note),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    context.push(Paths.mainMenu.path);
                  },
                  label: const Text('Back to Menu'),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
