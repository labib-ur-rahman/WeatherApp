import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/constants/text.dart';

import '../common/widgets/blur_background_effect.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BlurBackgroundEffect(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📍 Khilkhet, Dhaka - 1229',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      SLTexts.goodMorning,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(SLImages.sun),
                    Center(
                      child: Text(
                        '25°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'THUNDERSTORM',
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
                        'Friday 10 • 09:00am',
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
                        value1: '5:30am',
                        image1: SLImages.sun,
                        title2: 'Sunset',
                        value2: '7:30pm',
                        image2: SLImages.moon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(color: Colors.grey),
                    ),
                    ReusableRow(
                      title1: 'Temp Max',
                      value1: '12°C',
                      image1: SLImages.tempMax,
                      title2: 'Temp Min',
                      value2: '8°C',
                      image2: SLImages.tempMin,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({
    super.key,
    required this.title1,
    required this.value1,
    required this.image1,
    required this.title2,
    required this.value2,
    required this.image2,
  });

  final String title1;
  final String value1;
  final String image1;
  final String title2;
  final String value2;
  final String image2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(image1, width: 50, height: 50, scale: 8),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  value1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(image2, width: 50, height: 50, scale: 8),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2,
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  value2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
