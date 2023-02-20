import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_search_provider.dart';
import 'package:flutter_restaurant_app_api/component/restaurant_search.dart';
import 'dart:developer';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';
  
  @override
  initState() {
    ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService(), query: _query),
      child: const RestaurantSearch(),
    );
  }
  
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Search Restaurant',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Restaurant',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    log('value: $value');
                    _query = value;
                  });
                },
              ),
              Container(
                child: _query.isEmpty
                  ? SizedBox(
                      height: size.height * 0.6,
                      child: const Center(
                        child: Text('Restaurants Emtpy')
                      )
                    )
                  : ChangeNotifierProvider.value(
                    value: RestaurantSearchProvider(apiService: ApiService(), query: _query),
                    child: const RestaurantSearch(),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}