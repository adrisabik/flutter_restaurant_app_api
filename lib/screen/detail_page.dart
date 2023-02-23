import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant_app_api/data/api/api_service.dart';
import 'package:flutter_restaurant_app_api/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant_app_api/widgets/restaurant_detail.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: ChangeNotifierProvider.value(
        value: RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: _build(context)
        )
    );
  }

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return RestaurantDetailWidget(restaurant: state.result.restaurant);
          } else if (state.state == ResultState.noData) {
            return const Center(
              child: Material(
                child: Text("\nData Kosong"),
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
    );
  }

}