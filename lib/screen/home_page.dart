import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/screen/detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RestaurantsResult> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = ApiService().restaurantList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: 
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              FutureBuilder(
                future: _restaurants,
                builder: (context, AsyncSnapshot<RestaurantsResult> snapshot) {
                  var state = snapshot.connectionState;
                  if(state != ConnectionState.done){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                    if(snapshot.hasData){
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = snapshot.data?.restaurants[index];
                          return _buildRestaurantItem(context, restaurant!);
                          // return Text(restaurant!);
                        }
                      );
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
                },
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
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