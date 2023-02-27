import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/screen/search_page.dart';
import 'package:flutter_restaurant_app_api/widgets/restaurant_list.dart';
import 'package:flutter_restaurant_app_api/provider/database_provider.dart';


class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
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
      // body: Center(child: Text('Favourite Page')),
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DatabaseProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                var restaurant = state.favourites[index];
                return RestaurantList(restaurant: restaurant);
              }
            );
          } else if (state.state == ResultState.noData) {
            return const Center(
              child: Material(
                child: Text("\nData restoran favorit Kosong"),
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
      )
    );
  }
}