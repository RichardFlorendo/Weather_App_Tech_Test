import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_technical_exam/src/features/weather/application/providers.dart';
import 'package:weather_app_technical_exam/src/features/weather/domain/weather/weather_data.dart';
import 'package:weather_app_technical_exam/src/features/weather/presentation/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherProvider);
    final city = ref.watch(cityProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("JSON"),
        Text(city, style: Theme.of(context).textTheme.headlineMedium),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(e.toString()),
        ),
      ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("XML"),
        Text(city, style: Theme.of(context).textTheme.headlineMedium),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(e.toString()),
        ),
      ],
      ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child :
        Column(
          children: [
          WeatherIconImage(iconUrl: data.iconUrl, size: 120),
          Text(temp, style: textTheme.displayMedium),
          Text(highAndLow, style: textTheme.bodyMedium),
          ]
        )
    );
  }
}