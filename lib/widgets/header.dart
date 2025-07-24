import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_task/weather_provider.dart';
import '../services/weather_service.dart';
import '../provider_task/holiday_provider.dart';
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    // 23 de julio: OBTENCIÓN DE PROVIDERS Y LOCALIZACIONES
    // Obtenemos la instancia de AppLocalizations para acceder a todos nuestros textos traducidos.
    final localizations = AppLocalizations.of(context)!;
    final weatherProvider = context.watch<WeatherProvider>();
    final WeatherData? weather = weatherProvider.weatherData;
    final holidayProvider = context.watch<HolidayProvider>();
    final holidayToday = holidayProvider.todayHoliday;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://i.pinimg.com/474x/8a/b3/2b/8ab32bb74689d0cdc98b14fc2460a73c.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 23 de julio: TRADUCCIÓN AÑADIDA
                  // Usamos la nueva clave `greeting` que definimos en los archivos .arb.
                  // Le pasamos 'Alex' como parámetro. En un futuro, este nombre podría
                  // venir de un perfil de usuario.
                  Text(
                    localizations.greeting('Alex'),
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // 23 de julio: TRADUCCIÓN AÑADIDA
                  // Usamos la clave `todayTasksHeader` para el subtítulo.
                  Text(
                    localizations.todayTasksHeader,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (holidayToday != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  '${localizations.todayIsHoliday}: ${holidayToday.localName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          const SizedBox(height: 16),

          // --- 23 de julio: SECCIÓN DEL CLIMA TOTALMENTE TRADUCIDA ---
          // La lógica de renderizado condicional ahora muestra textos traducidos.

          // Condición 1: ¿Está cargando?
          if (weatherProvider.isLoading)
            Center(
              child: Text(
                // Usamos la clave `weatherLoading`.
                localizations.weatherLoading,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

          // Condición 2: ¿Hay un error?
          // Leemos el estado `hasError` del provider.
          if (weatherProvider.hasError)
            Center(
              child: Text(
                // Usamos la clave `weatherError`.
                localizations.weatherError,
                style: const TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

          // Condición 3: ¿Tenemos datos?
          if (weather != null && !weatherProvider.isLoading && !weatherProvider.hasError)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.cloud_off, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    // La descripción del clima ahora también se pone en mayúscula
                    // de forma segura para cualquier idioma.
                    '${weather.temperature.toStringAsFixed(1)}°C, ${weather.description[0].toUpperCase()}${weather.description.substring(1)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
