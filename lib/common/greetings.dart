import 'package:weather_app/constants/text.dart';

class SLGreetings {
  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return SLTexts.goodMorning;
    } else if (hour >= 12 && hour < 17) {
      return SLTexts.goodAfternoon;
    } else if (hour >= 17 && hour < 21) {
      return SLTexts.goodEvening;
    } else {
      return SLTexts.goodNight;
    }
  }
}
