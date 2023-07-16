import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/weather_data.dart';

class DataService with ChangeNotifier {
   DateTime _currentTime=DateTime.now();
  DateTime get currentTime=>_currentTime;

  bool _noDataFound = true;
  bool get noDataFound => _noDataFound;

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  bool _error = false;
  bool get error => _error;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  WeatherData _weartherData = WeatherData();
  WeatherData get weartherData => _weartherData;
  set visibility(bool visible) {
    _isVisible = visible;
    notifyListeners();
  }

  Future<WeatherData> getWeather(String? city) async {
    final parameters = {
      'q': city,
      'appid': 'e51f38b6c7af216e57340f626c804b50',
      'units': 'metric'
    };

    try {
      final uri =
          Uri.https('api.openweathermap.org', '/data/2.5/weather', parameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
if (kDebugMode) {
  print(response.body);
}
        _isVisible = true;
        _noDataFound = false;
        _error = false;
        _errorMessage = '';
        _weartherData = WeatherData.fromjson(json);
        _currentTime=DateTime.now();
        notifyListeners();
      } else {
        _isVisible = true;
        _noDataFound = true;
        _error = true;
        _errorMessage = 'City Not Found!Try Again.';
        _currentTime=DateTime.now();
        notifyListeners();
      }
    } catch (e) {
      _isVisible = true;
      _noDataFound = true;
      _error = true;
      _errorMessage = 'Oops!! It Might Be Your Internet Connection \n      Check your Connection and Refresh';
      _currentTime=DateTime.now();
      notifyListeners();
    }

    return _weartherData;
  }
}
