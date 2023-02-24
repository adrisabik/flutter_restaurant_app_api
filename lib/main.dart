import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/provider/restaurants_provider.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_search_provider.dart';
import 'package:flutter_restaurant_app_api/screen/home_page.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';
import 'package:flutter_restaurant_app_api/screen/search_page.dart';
import 'package:flutter_restaurant_app_api/data/db/database_helper.dart';
import 'package:flutter_restaurant_app_api/provider/database_provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant_app_api/utils/background_service.dart';
import 'package:flutter_restaurant_app_api/utils/notification_helper.dart';
import 'package:flutter_restaurant_app_api/provider/scheduling_provider.dart';
import 'package:flutter_restaurant_app_api/provider/preferences_provider.dart';
import 'package:flutter_restaurant_app_api/data/preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance()
            )
          )
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: null),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService(), query: null)
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())
        )
      ],
      child: MaterialApp(
        title: 'Restaruant App API',
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
            id: ModalRoute.of(context)!.settings.arguments as String,
          ),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      )
    );
  }
}
