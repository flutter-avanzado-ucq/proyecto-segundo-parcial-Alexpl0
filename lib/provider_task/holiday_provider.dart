import 'package:flutter/material.dart';
import '../services/holiday_service.dart';

class HolidayProvider extends ChangeNotifier {
  final HolidayService _holidayService = HolidayService();
  List<Holiday>? _holidays;
  bool _isLoading = false;
  // 23 de julio: MODIFICADO - Cambiamos el mensaje de error a un booleano.
  bool _hasError = false;

  List<Holiday>? get holidays => _holidays;
  bool get isLoading => _isLoading;
  // 23 de julio: MODIFICADO - El getter ahora devuelve el estado de error.
  bool get hasError => _hasError;

  /// Carga los feriados del país y año especificados
  Future<void> loadHolidays(
      {required int year, required String countryCode}) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final data = await _holidayService.fetchHolidays(
          year: year, countryCode: countryCode);
      _holidays = data;
    } catch (e) {
      // 23 de julio: MODIFICADO - Marcamos que hubo un error.
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Verifica si hoy es feriado
  Holiday? get todayHoliday {
    if (_holidays == null) return null;

    final today = DateTime.now();
    //final today = DateTime(2025, 9, 16); // fecha de prueba
    try {
      return _holidays!.firstWhere(
        (holiday) =>
            holiday.date.year == today.year &&
            holiday.date.month == today.month &&
            holiday.date.day == today.day,
      );
    } catch (_) {
      return null;
    }
  }
}
