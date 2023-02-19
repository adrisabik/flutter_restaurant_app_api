import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurantDetail.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<RestaurantDetailResult> _restaurantDetail;

  @override
  void initState() {
    super.initState();
    _restaurantDetail = ApiService().restaurantDetail(widget.id);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: SingleChildScrollView(
        child: 
          FutureBuilder(
            future: _restaurantDetail,
            builder: (context, AsyncSnapshot<RestaurantDetailResult> snapshot){
              var state = snapshot.connectionState;
              if(state != ConnectionState.done){
                return const Center(child: CircularProgressIndicator());
              }
              else {
                if(snapshot.hasData){
                  var restaurant = snapshot.data?.restaurant;
                  return _buildRestaurantDetail(context, restaurant!);
                }
                else if(snapshot.hasError){
                  return Center(
                    child: Material(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else {
                  return const Material(child: Text(''));
                }
              }
            }
          )
      )
    );
  }

  Widget _buildRestaurantDetail(BuildContext context, Restaurant restaurant){
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