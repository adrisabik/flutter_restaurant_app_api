import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant_search.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String ?query;

  RestaurantSearchProvider({required this.apiService, this.query}){
    _fetchSearchRestaurants();
  }

  late RestaurantSearchResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantSearchResult get result => _restaurantsResult;
  ResultState get state => _state;

  Future<dynamic> _fetchSearchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.restaurantSearch(query);
      if(restaurants.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    }
    catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

}