import 'dart:convert';
import 'dart:developer';
import 'package:flutter_restaurant_app_api/common/navigation.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        log('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, Restaurant restaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurants app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId, channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Recommended Restaurant for you!</b>";
    var titleRestaurants = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0, titleNotification, titleRestaurants, platformChannelSpecifics,
      payload: json.encode(restaurant.toJson())
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantsResult.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}
