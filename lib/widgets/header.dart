import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 21 de julio: AÑADIDO - Importación del WeatherProvider.
// Necesitamos importar el provider para poder acceder a los datos del clima que se están gestionando.
import '../provider_task/weather_provider.dart';
// 21 de julio: AÑADIDO (Opcional pero buena práctica) - Importación del WeatherService.
// Aunque no lo usamos directamente, importar el service nos da acceso al modelo `WeatherData`.
import '../services/weather_service.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    // 21 de julio: AÑADIDO - Acceso al estado del clima usando Provider.
    // Esta línea es el corazón de la integración en la UI.
    // `context.watch<WeatherProvider>()` hace dos cosas muy importantes:
    // 1. **Obtiene la instancia:** Busca en el árbol de widgets hacia arriba hasta que encuentra
    //    el `WeatherProvider` que registramos en `main.dart` y nos da acceso a él.
    // 2. **Establece una suscripción:** `.watch()` le dice a Flutter: "Oye, este widget `Header`
    //    depende de los datos de `WeatherProvider`. Si `WeatherProvider` llama a `notifyListeners()`,
    //    tienes que reconstruir este widget `Header` porque su apariencia podría necesitar cambiar".
    //    Esto es lo que hace que la UI sea reactiva.
    final weatherProvider = context.watch<WeatherProvider>();
    // Para simplificar el acceso, guardamos los datos del clima (que pueden ser nulos al principio)
    // en una variable local.
    final WeatherData? weather = weatherProvider.weatherData;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      // 21 de julio: MODIFICADO - Se cambió el widget principal de Row a Column.
      // El diseño original usaba un Row para el avatar y el texto de saludo.
      // Se cambió a un Column para poder apilar verticalmente el saludo original
      // y, debajo de él, la nueva sección con la información del clima.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contenido original del saludo
          const Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://i.pinimg.com/474x/8a/b3/2b/8ab32bb74689d0cdc98b14fc2460a73c.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, Alex 👋',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Estas son tus tareas para hoy',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- 21 de julio: AÑADIDO - SECCIÓN DE RENDERIZADO CONDICIONAL DEL CLIMA ---
          // Esta es la lógica que controla QUÉ se muestra en la pantalla y CUÁNDO.
          // Es una práctica fundamental en Flutter para crear UIs dinámicas que responden al estado.

          // Condición 1: ¿La información está cargando?
          // `weatherProvider.isLoading` es un booleano que nuestro provider pone en `true`
          // justo antes de empezar la petición a la API.
          // Si es `true`, mostramos un `CircularProgressIndicator` para darle feedback visual
          // al usuario de que "algo está pasando". Esto mejora enormemente la experiencia de usuario.
          if (weatherProvider.isLoading)
            const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              ),
            ),

          // Condición 2: ¿Ocurrió un error?
          // `weatherProvider.errorMessage` es un String que contendrá un mensaje si la petición
          // a la API falla por cualquier motivo (sin internet, error del servidor, etc.).
          // Si no es nulo, significa que algo salió mal. Mostramos el mensaje de error
          // para que el usuario sepa qué pasó, en lugar de simplemente no mostrar nada.
          if (weatherProvider.errorMessage != null)
            Center(
              child: Text(
                weatherProvider.errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

          // Condición 3: ¿Tenemos los datos exitosamente?
          // `weather` (que es `weatherProvider.weatherData`) contendrá un objeto `WeatherData`
          // si la petición fue exitosa. Si no es nulo, podemos construir la UI del clima.
          if (weather != null)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // El ícono del clima. La URL se construye dinámicamente usando el `iconCode`
                  // que nos devuelve la API (ej. "10d", "01n").
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                    width: 35,
                    height: 35,
                    // Buena práctica: `errorBuilder` muestra un ícono de respaldo si la imagen no se puede cargar.
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.cloud_off, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 8),
                  // El texto con la temperatura y la descripción.
                  Text(
                    // `toStringAsFixed(1)` formatea la temperatura para que solo tenga un decimal.
                    // `weather.description[0].toUpperCase() + weather.description.substring(1)`
                    // es un truco para poner en mayúscula solo la primera letra de la descripción (ej. "lluvia ligera" -> "Lluvia ligera").
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
