import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/screen/search_page.dart';
import 'package:flutter_restaurant_app_api/provider/restaurants_provider.dart';
import 'package:flutter_restaurant_app_api/widgets/restaurant_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Apps'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              child: const Icon(
                Icons.search,
                size: 26.0,
              ),
            )
          ),
        ]
      ),
      body: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0
            ),
            child: const Text(
              'Recommended restaurants for you',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Consumer<RestaurantsProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return RestaurantList(restaurant: restaurant);
                  }
                );
              } else if (state.state == ResultState.noData) {
                return const Center(
                  child: Material(
                    child: Text("\nData restoran Kosong"),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return const Center(
                  child: Material(
                    child: Text("\nPeriksa kembali koneksi internet anda"),
                  ),
                );
              } else {
                return const Center(
                  child: Material(
                    child: Text(''),
                  ),
                );
              }
            },
          ),
    
        ]
      ),
    );
  }
}