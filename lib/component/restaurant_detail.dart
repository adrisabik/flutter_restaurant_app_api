import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant_detail.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_detail_provider.dart';


class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: _buildDetail(context)
    );
  }

  Widget _buildDetail(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return _buildRestaurantDetail(context, state.result.restaurant);
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
    );
  }

  _buildRestaurantDetail(BuildContext context, RestaurantDetail restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0, 
        vertical: 8.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.blue,
                    size: 16,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 16,
              ),
              Text(
                restaurant.city,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            restaurant.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Foods',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.menus.foods.map((food) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(food.name),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Drinks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.menus.drinks.map((drink) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(drink.name),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 36),

        ],
      )
    );
  }

  
}