import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_search_provider.dart';
import 'package:flutter_restaurant_app_api/component/restaurant_search.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';
  
  @override
  Widget build(BuildContext context) {
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
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Restaurant',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _query = value;
                    });
                  },
                ),
              ),
              Container(
                child: _query.isEmpty
                  ? const Center(child: Text('Empty'))
                  : ChangeNotifierProvider<RestaurantSearchProvider>(
                    create: (_) => RestaurantSearchProvider(apiService: ApiService(), query: _query),
                    child: const RestaurantSearch(),
                  ),
                  // : Text(_query)
              ),
            ],
          ),
        ),
      ),
    );
  }
}