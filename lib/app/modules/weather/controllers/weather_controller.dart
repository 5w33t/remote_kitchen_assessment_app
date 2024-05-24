import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/modules/weather/providers/weather_provider.dart';
import 'package:remote_kitchen_assessment_app/app/modules/weather/models/weather_model.dart';

class WeatherController extends GetxController {
  final isLoading = RxBool(false);
  final WeatherProvider _weatherProvider = WeatherProvider();
  final weather = RxList<Weather>([]);
  final isFailed = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  String getConditionAnimation(String condition) {
    if (condition.contains('sun')) {
      return 'assets/anims/sunny.json';
    } else if (condition.contains('cloud')) {
      return 'assets/anims/cloudy.json';
    } else if (condition.contains('rain')) {
      return 'assets/anims/rain.json';
    } else if (condition.contains('snow')) {
      return 'assets/anims/snow.json';
    } else {
      return 'assets/anims/sunny.json';
    }
  }

  int getIntegerTemp(String temp) {
    double val = double.tryParse(temp)!;
    return val.round();
  }

  Future<void> fetchWeather() async {
    isLoading.value = true;
    try {
      final currentCity = await _weatherProvider.getCurrentCity();
      final fetchedWeather = await _weatherProvider.fetchWeather(currentCity);
      weather.value = [fetchedWeather];
    } catch (error) {
      Get.snackbar('You\'re Offline.', 'Please check your internet connection',
          backgroundColor: Colors.red.shade900,
          colorText: Colors.blueGrey.shade100,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
          ));
    } finally {
      isLoading.value = false;
    }
  }
}
