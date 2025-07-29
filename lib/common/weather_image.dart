import 'package:weather_app/constants/images.dart';

class WeatherImage {
  // This method now requires if it's day or night
  static String getWeatherAnimation(
    String? condition, {
    required bool isDayTime,
  }) {
    if (condition == null) {
      return isDayTime ? SLImages.snowyDay : SLImages.snowyNight;
    }

    final conditionLower = condition.toLowerCase();

    if (conditionLower.contains('thunder')) return SLImages.thunderstorm;

    if (conditionLower.contains('cloud')) {
      return isDayTime ? SLImages.cloudyDay : SLImages.cloudyNight;
    }

    if (conditionLower.contains('rain')) {
      return isDayTime ? SLImages.rainyDay : SLImages.rainyNight;
    }

    if (conditionLower.contains('fog') || conditionLower.contains('mist')) {
      return SLImages.foggy;
    }

    if (conditionLower.contains('snow')) {
      return isDayTime ? SLImages.snowyDay : SLImages.snowyNight;
    }

    // Fallback
    return isDayTime ? SLImages.snowyDay : SLImages.snowyNight;
  }
}
