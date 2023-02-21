import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/screen/list_page.dart';
import 'package:flutter_restaurant_app_api/screen/favourite_page.dart';


class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Restaurant App';

  final List<Widget> _listWidget = [
    const ListPage(),
    const FavouritePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _headlineText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: _headlineText,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider<RestaurantsProvider>(
  //     create: (_) => RestaurantsProvider(apiService: ApiService()),
  //     child: const RestaurantList(),
  //   );
  // }

  
}