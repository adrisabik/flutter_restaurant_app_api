import 'package:flutter_restaurant_app_api/data/db/database_helper.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter/foundation.dart';

enum ResultState { loading, noData, hasData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavourites();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favourites = [];
  List<Restaurant> get favourites => _favourites;

  void _getFavourites() async {
    _favourites = await databaseHelper.getFavourites();
    if (_favourites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavourite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavourite(restaurant);
      _getFavourites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourited(String id) async {
    final bookmarkedRestaurant = await databaseHelper.getFavouriteByUrl(id);
    return bookmarkedRestaurant.isNotEmpty;
  }

  void removeFavourite(String id) async {
    try {
      await databaseHelper.removeFavourite(id);
      _getFavourites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
