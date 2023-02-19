import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/screen/home_page.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';
import 'package:flutter_restaurant_app_api/screen/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
