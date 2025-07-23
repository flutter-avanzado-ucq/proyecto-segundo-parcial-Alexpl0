import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';
import 'provider_task/task_provider.dart';
import 'provider_task/theme_provider.dart';
// 21 de julio: AÑADIDO - Importación del WeatherProvider.
// Se importa el archivo 'weather_provider.dart' para poder tener acceso a la clase WeatherProvider.
// Esta clase es la que gestionará todo lo relacionado con el estado del clima:
// hará la petición a la API, almacenará los datos, y notificará a los widgets cuando haya cambios.
import 'provider_task/weather_provider.dart';
import 'models/task_model.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasksBox');

  await NotificationService.initializeNotifications();

  await NotificationService.requestPermission();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
        // 21 de julio: AÑADIDO - Registro del WeatherProvider en el árbol de widgets.
        // Aquí se está utilizando un `MultiProvider` para poder registrar varios providers
        // a la vez en el nivel más alto de la aplicación.
        // Al añadir `ChangeNotifierProvider(create: (_) => WeatherProvider())`, estamos creando
        // una instancia de nuestro `WeatherProvider` y poniéndola a disposición de CUALQUIER
        // widget que se encuentre por debajo en el árbol de widgets (básicamente, toda la app).
        //
        // ¿Por qué es crucial esto?
        // 1. **Acceso Global:** Permite que widgets como `TaskScreen` o `Header` puedan "pedir"
        //    esta instancia del `WeatherProvider` para acceder a los datos del clima o para
        //    llamar a sus métodos (como `loadWeather`).
        // 2. **Gestión de Estado Centralizada:** El estado del clima (si está cargando, si hay un error,
        //    o los datos mismos) vive en un único lugar, el `WeatherProvider`. Esto evita tener
        //    lógica de negocio esparcida por múltiples widgets y simplifica el mantenimiento.
        // 3. **Eficiencia:** Provider es inteligente. Solo reconstruirá los widgets que están
        //    "escuchando" activamente los cambios en `WeatherProvider`, mejorando el rendimiento
        //    de la aplicación.
        //
        // La función `create: (_) => WeatherProvider()` es la que efectivamente instancia la clase.
        // El `_` es una convención para indicar que no nos interesa el `BuildContext` que `create` nos ofrece.
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tareas Pro',
          theme: AppTheme.theme,
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const TaskScreen(),
        );
      },
    );
  }
}
