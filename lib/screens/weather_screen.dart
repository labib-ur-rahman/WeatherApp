import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/secrets.dart';

import '../common/greetings.dart';
import '../common/weather_image.dart';
import '../common/widgets/blur_background_effect.dart';
import '../constants/images.dart';
import '../models/weather_models.dart';
import '../services/weather_service.dart';
import '../common/widgets/reusable_row.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService(Secrets.weatherApiKey);

  WeatherModel? _weather;
  String? _area;
  bool _isLoading = true;

  Future<void> _fetchWeather() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services are disabled.');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permission permanently denied. Enable from settings.');
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark placemark = placemarks.first;
      String road = placemark.thoroughfare ?? '';
      String subLocality = placemark.subLocality ?? '';
      String city = placemark.locality ?? 'Unknown';

      String area = subLocality.isNotEmpty
          ? '$road, $subLocality, $city'
          : '$road, $city';

      final weather = await _weatherService.fetchWeather(city);

      setState(() {
        _weather = weather;
        _area = area;
        _isLoading = false;
      });
    } catch (e) {
      print('Weather fetch error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    // Compute isDayTime only if _weather is loaded and sunrise/sunset exist
    bool isDayTime = true; // default to true

    final weather = _weather;
    if (weather?.sunrise != null && weather?.sunset != null) {
      final now = DateTime.now();
      final sunrise = weather!.sunrise;
      final sunset = weather.sunset;
      isDayTime = now.isAfter(sunrise) && now.isBefore(sunset);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isLoading,
            child: SingleChildScrollView(
              physics: _isLoading
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, kToolbarHeight, 40, 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      BlurBackgroundEffect(),
                      _buildWeatherContent(isDayTime),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Stack(
                children: [
                  BlurBackgroundEffect(),
                  Center(
                    child: Lottie.asset(
                      SLImages.weatherLoadingAnimation,
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Pass isDayTime to _buildWeatherContent so it can pass to Lottie
  Widget _buildWeatherContent(bool isDayTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Text(
              _area ?? 'Loading location...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          SLGreetings.getGreeting(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Lottie.asset(
            WeatherImage.getWeatherAnimation(
              _weather?.description,
              isDayTime: isDayTime,
            ),
            height: 280,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            _weather != null ? '${_weather!.temperature.round()}°C' : '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 55,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Center(
          child: Text(
            _weather?.description.toUpperCase() ?? '••••••••',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 6),
        Center(
          child: Text(
            _weather != null
                ? DateFormat('EEEE d • hh:mma').format(_weather!.dateTime)
                : 'Loading...',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: ReusableRow(
            title1: 'Sunrise',
            value1: _weather != null
                ? DateFormat('h:mma').format(_weather!.sunrise)
                : '--',
            image1: SLImages.sun,
            title2: 'Sunset',
            value2: _weather != null
                ? DateFormat('h:mma').format(_weather!.sunset)
                : '--',
            image2: SLImages.moon,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(color: Colors.grey),
        ),
        ReusableRow(
          title1: 'Temp Max',
          value1: _weather != null ? '${_weather!.tempMax.round()}°C' : '--',
          image1: SLImages.tempMax,
          title2: 'Temp Min',
          value2: _weather != null ? '${_weather!.tempMin.round()}°C' : '--',
          image2: SLImages.tempMin,
        ),
      ],
    );
  }
}
