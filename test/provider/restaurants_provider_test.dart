import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_restaurant_app_api/data/model/restaurant.dart';
 
void main() {
  test('should contain list restaurant when module completed', () async {
    var testRestaurant = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    var result = Restaurant.fromJson(testRestaurant).id;

    expect(result, "rqdv5juczeskfw1e867");
  });
}