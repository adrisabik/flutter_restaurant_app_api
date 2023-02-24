import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantsPreferences();
  }

  bool _isDailyRestaurantsActive = false;
  bool get isDailyRestaurantsActive => _isDailyRestaurantsActive;

  void _getDailyRestaurantsPreferences() async {
    _isDailyRestaurantsActive = await preferencesHelper.isDailyRestaurantsActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantsPreferences();
  }
}
