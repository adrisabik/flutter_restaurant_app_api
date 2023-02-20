import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/screen/search_page.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter_restaurant_app_api/provider/restaurants_provider.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';


class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

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
                    return _buildRestaurantItem(context, restaurant);
                  }
                );
              } else if (state.state == ResultState.noData) {
                return const Center(
                  child: Material(
                    child: Text("Data Kosong"),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return const Center(
                  child: Material(
                    child: Text("Periksa kembali koneksi internet anda"),
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

  _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),   
      title: Text(
        restaurant.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      isThreeLine: true,
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 12,
              ),
              Text(
                restaurant.city,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.blue,
                size: 12,
              ),
              Text(
                restaurant.rating.toString(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      
      onTap: () {
        String id = restaurant.id;
        Navigator.pushNamed(context, DetailPage.routeName, arguments: id);
      },
    );
  }

  
}