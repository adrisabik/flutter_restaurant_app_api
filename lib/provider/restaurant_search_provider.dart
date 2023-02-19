import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'dart:developer';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchAllRestaurants();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantsResult get result => _restaurantsResult;
  ResultState get state => _state;

  // Future<dynamic> _fetchAllRestaurants() async {
    
  //   try {
  //     log('data: $query');
  //     _state = ResultState.loading;
  //     notifyListeners();
  //     await apiService.restaurantSearch(query).then((response) {
  //       log('data: $query');
  //       if (response.restaurants.isEmpty) {
  //         _state = ResultState.noData;
  //         notifyListeners();
  //         return _message = 'No Data';
  //       } else {
  //         _state = ResultState.hasData;
  //         notifyListeners();
  //         return _restaurantsResult = response;
  //       }
  //     });
  //     log('data: $query');
  //   } catch (e) {
  //     _state = ResultState.error;
  //     notifyListeners();
  //     return _message = 'Error: $e';
  //   }
  // }
  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.restaurantSearch(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

}