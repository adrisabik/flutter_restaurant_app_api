import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/provider/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant_detail.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';

class RestaurantDetailWidget extends StatelessWidget {
  final RestaurantDetail restaurant;

  const RestaurantDetailWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    Restaurant singleRestaurant = Restaurant(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );

    return Consumer<DatabaseProvider>(
      builder: (context, provider, _){
      return FutureBuilder<bool>(
        future: provider.isFavourited(restaurant.id),
        builder: (context, snapshot){
          var isFavourited = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0, 
              vertical: 8.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x20000000),
                              spreadRadius:1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28.0),
                          child: Container(
                            color: Colors.white,
                            child: isFavourited 
                            ? IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                size: 28,
                              ),
                              color: Colors.blue,
                              onPressed: () => provider.removeFavourite(restaurant.id),
                            )
                            : IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 28,
                              ),
                              color: Colors.blue,
                              onPressed: () => provider.addFavourite(singleRestaurant),
                            )
                          ),
                        ),
                      ),
                    )
                  ]
                ),
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
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
      );

      }
    );
  }
}