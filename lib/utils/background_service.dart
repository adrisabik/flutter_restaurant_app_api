import 'dart:ui';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter_restaurant_app_api/main.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().restaurantList();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin, 
      result.restaurants[Random().nextInt(result.restaurants.length - 1)],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
