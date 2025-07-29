class WeatherModel {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String mainCondition;
  final String description;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime dateTime;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.mainCondition,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.dateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
        isUtc: true,
      ).toLocal(),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunset'] * 1000,
        isUtc: true,
      ).toLocal(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        json['dt'] * 1000,
        isUtc: true,
      ).toLocal(),
    );
  }
}
