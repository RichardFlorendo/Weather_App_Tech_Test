import 'package:flutter/material.dart';
import 'package:weather_app_technical_exam/src/constants/app_colors.dart';
import 'package:weather_app_technical_exam/src/features/weather/presentation/city_search_box.dart';
import 'package:weather_app_technical_exam/src/features/weather/presentation/current_weather.dart';
import 'package:weather_app_technical_exam/src/features/weather/presentation/hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.appColor,
        ),
          child: Column( 
            children: [ 
            const CitySearchBox(),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(15.0),
              children: const [
                CurrentWeather(),
                HourlyWeather(),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
