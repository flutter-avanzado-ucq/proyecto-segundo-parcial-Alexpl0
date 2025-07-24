import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weatherData;
  bool _isLoading = false;
  bool _hasError = false;

  WeatherData? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  // 23 de julio: CORREGIDO - La firma del método ahora usa parámetros nombrados.
  // Esto coincide con la forma en que se llama desde `tarea_screen.dart` y resuelve el error.
  Future<void> loadWeather({
    required double lat,
    required double lon,
    required String lang,
  }) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      // Pasamos los parámetros al servicio.
      final data = await _weatherService.fetchWeatherByLocation(lat, lon, lang);
      _weatherData = data;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
