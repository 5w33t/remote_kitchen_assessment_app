import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';

import '../controllers/weather_controller.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Weather API',
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (controller.isFailed.isTrue) {
            return const Center(
              child: Text(
                  'Failed to fetch data. Please try again after some time.'),
            );
          }
          final weather = controller.weather[0];
          final primaryColor =
              weather.isDay == '1' ? Colors.white : Colors.black87;
          final secondaryColor =
              weather.isDay == '0' ? Colors.white : Colors.black87;
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      weather.city,
                      textAlign: TextAlign.start,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                    ),
                    Text(
                      weather.country,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: secondaryColor,
                          ),
                    ),
                    Icon(
                      Icons.location_on,
                      color: secondaryColor,
                      size: 15,
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            controller.getConditionAnimation(weather.condition),
                            height: 200,
                          ),
                          Text(
                            weather.condition.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: secondaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Current Temperature',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: secondaryColor,
                                    ),
                              ),
                              Text(
                                '${controller.getIntegerTemp(weather.temp)}°C',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                'Temperature Feels Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: secondaryColor,
                                    ),
                              ),
                              Text(
                                '${controller.getIntegerTemp(weather.feelsLike)}°C',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 500,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
