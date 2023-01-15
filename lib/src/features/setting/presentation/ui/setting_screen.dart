import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/setting/application/font_size_service.dart';

import '../../application/dark_mode_service.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = ref.watch(darkModeServiceProvider);
    int fontSize = ref.watch(fontSizeServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      backgroundColor: !darkMode
          ? const Color(0xFFE5E5E5)
          : Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: const Icon(Icons.brightness_6),
                title: const Text('Mode sombre'),
                trailing: Switch(
                  value: darkMode,
                  onChanged: (value) {
                    ref.read(darkModeServiceProvider.notifier).toggle();
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: const Text('Taille de la police'),
                leading: const Icon(Icons.format_size),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: fontSize.toDouble(),
                      min: 14,
                      max: 50,
                      divisions: 12,
                      label: fontSize.toString(),
                      onChanged: (value) {
                        ref
                            .read(fontSizeServiceProvider.notifier)
                            .setFontSize(value.toInt());
                      },
                    ),
                    Text(
                      'Current font size: $fontSize',
                      style: TextStyle(
                        fontSize: fontSize.toDouble(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
