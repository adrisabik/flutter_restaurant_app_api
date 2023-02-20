import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant_search.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_search_provider.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';

class RestaurantSearch extends StatelessWidget{
  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Container(
            height: size.height * 0.6,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
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
              child: Text("Data kosong"),
            ),
          );
        } else if (state.state == ResultState.error) {
          return const Center(
            child: Material(
              child: Text("Periksas kembali koneksi internet anda"),
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
    );
  }

  _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
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
