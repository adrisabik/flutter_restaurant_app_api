import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantList({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
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