import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const AppScroll(
        bottomPadding: 24,
        children: [
          AppCard(
            child: Column(
              children: [
                SettingTile(
                  Icons.language_rounded,
                  'Language',
                  'English / اردو',
                ),
                Divider(),
                SettingTile(
                  Icons.cloud_sync_rounded,
                  'Laravel API',
                  'Sanctum backend connection',
                ),
                Divider(),
                SettingTile(
                  Icons.auto_awesome_rounded,
                  'Gemini Parsing',
                  'Voice and text AI extraction',
                ),
                Divider(),
                SettingTile(
                  Icons.security_rounded,
                  'Privacy',
                  'Local permissions and account security',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
