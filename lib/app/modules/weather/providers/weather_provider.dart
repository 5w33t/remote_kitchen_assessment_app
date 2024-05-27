import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/modules/weather/secrets/weather_api_key.dart';
import '../models/weather_model.dart';

class WeatherProvider extends GetConnect {
  Future<Weather> fetchWeather(String city) async {
    // final url = Uri.parse(
    //     'https://api.weatherapi.com/v1/current.json?key=$weatherAPIKey&q=$city');
    // final response = await http.get(url);

    final response = await get(
        'https://api.weatherapi.com/v1/current.json?key=$weatherAPIKey&q=$city');

    if (response.status.code == 200) {
      var weather = Weather.fromJson(json.decode(response.bodyString!));
      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks[0].locality ?? 'Rajshahi';
    return city.toString();
  }

}
