import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:weather_app/app.dart';

void main() =>
    runApp(DevicePreview(builder: (context) => App(), enabled: !kReleaseMode));
