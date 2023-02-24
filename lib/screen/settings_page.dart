import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/provider/preferences_provider.dart';
import 'package:flutter_restaurant_app_api/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling Restaurants'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestaurantsActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurants(value);
                        provider.enableDailyNews(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}