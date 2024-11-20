import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_technical_exam/src/features/weather/application/providers.dart';
import 'package:weather_app_technical_exam/src/features/weather/domain/weather/weather_data.dart';
import 'package:weather_app_technical_exam/src/features/weather/presentation/weather_icon_image.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastDataValue = ref.watch(hourlyWeatherProvider);
    return forecastDataValue.when(
      data: (forecastData) {
        final items = [0, 8, 16, 24, 32];
        return HourlyWeatherColumn(
          weatherDataItems: [
            for (var i in items) forecastData.list[i],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class HourlyWeatherColumn extends StatelessWidget {
  const HourlyWeatherColumn({super.key, required this.weatherDataItems});
  final List<WeatherData> weatherDataItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: weatherDataItems
              .map((data) => HourlyWeatherItem(data: data))
              .toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: weatherDataItems
              .map((data) => HourlyWeatherItem(data: data))
              .toList(),
        ),
      ],
    );
  }
}

class HourlyWeatherItem extends ConsumerWidget {
  const HourlyWeatherItem({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    const fontWeight = FontWeight.normal;
    final temp = data.temp.celsius.toInt().toString();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: [
          Text(
            DateFormat.E().format(data.date),
            style: textTheme.bodySmall!.copyWith(fontWeight: fontWeight),
          ),
          const SizedBox(height: 6),
          WeatherIconImage(iconUrl: data.iconUrl, size: 40),
          const SizedBox(height: 6),
          Text(
            '$temp°',
            style: textTheme.bodyLarge!.copyWith(fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}
