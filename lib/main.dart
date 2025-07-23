import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';
import 'provider_task/task_provider.dart';
import 'provider_task/theme_provider.dart';
<<<<<<< HEAD
// 21 de julio: AÑADIDO - Importación del WeatherProvider.
// Se importa el archivo 'weather_provider.dart' para poder tener acceso a la clase WeatherProvider.
// Esta clase es la que gestionará todo lo relacionado con el estado del clima:
// hará la petición a la API, almacenará los datos, y notificará a los widgets cuando haya cambios.
import 'provider_task/weather_provider.dart';
=======
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f
import 'models/task_model.dart';
import 'services/notification_service.dart';

// 07 de Julio del 2025: Importaciones para la internacionalización.
// 'app_localizations.dart' es la clase principal generada por Flutter para manejar las traducciones.
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
// 'flutter_localizations.dart' provee los delegados necesarios para que los widgets de Flutter (Material, Cupertino) se traduzcan.
import 'package:flutter_localizations/flutter_localizations.dart';
// 07 de Julio del 2025: Se importa el nuevo LocaleProvider creado para el proyecto.
import 'provider_task/locale_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');

  await NotificationService.initializeNotifications();
  await NotificationService.requestPermission();

  runApp(
<<<<<<< HEAD
=======
    // 07 de Julio del 2025: MultiProvider permite registrar varios providers en el árbol de widgets.
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
<<<<<<< HEAD
        
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
=======
        // 07 de Julio del 2025: Se registra el LocaleProvider.
        // Ahora, cualquier widget descendiente de MyApp podrá acceder a LocaleProvider
        // para obtener o modificar el estado del idioma.
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    // 07 de Julio del 2025: Se usa Consumer para escuchar tanto a ThemeProvider como a LocaleProvider.
    // En lugar de un solo Consumer, se pueden envolver uno dentro de otro o usar `context.watch`.
    // En este caso, se usan dos `watchers` dentro del build.
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        // 07 de Julio del 2025: El título de la app ahora se obtiene de las localizaciones.
        return AppLocalizations.of(context)!.appTitle;
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f
      },
      theme: AppTheme.theme,
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // 07 de Julio del 2025: Configuración del idioma (locale).
      // Esta propiedad le indica a MaterialApp qué idioma usar. Se obtiene de localeProvider.
      // Si es 'null', Flutter usará el idioma del sistema.
      locale: localeProvider.locale,

      // 07 de Julio del 2025: Delegados de localización.
      // Los delegados son responsables de cargar las traducciones.
      localizationsDelegates: const [
        // 07 de Julio del 2025: AppLocalizations.delegate carga las traducciones de los archivos .arb.
        AppLocalizations.delegate,
        // 07 de Julio del 2025: Estos delegados cargan las traducciones por defecto de los widgets de Flutter.
        // Por ejemplo, traducen textos como "OK", "Cancel" en diálogos, etc.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 07 de Julio del 2025: Idiomas soportados por la aplicación.
      // Esto informa a Flutter qué idiomas están disponibles.
      supportedLocales: const [
        Locale('en'), // Inglés
        Locale('es'), // Español
      ],

      // 07 de Julio del 2025: Callback para resolver el idioma.
      // Esta función se ejecuta cuando la app inicia o el idioma del sistema cambia.
      // Decide qué 'locale' usar. Es la lógica personalizada para la selección de idioma.
      localeResolutionCallback: (locale, supportedLocales) {
        // 07 de Julio del 2025: Prioridad 1: Usar el idioma guardado por el usuario.
        // Si el usuario ya eligió un idioma en la app (y por tanto, localeProvider.locale no es nulo),
        // se usa ese sin importar el idioma del sistema.
        if (localeProvider.locale != null) {
          return localeProvider.locale;
        }

        // 07 de Julio del 2025: Prioridad 2: Usar el idioma del dispositivo si es compatible.
        // Si el usuario no ha elegido un idioma, se revisa si el idioma del dispositivo ('locale')
        // está en la lista de idiomas soportados ('supportedLocales').
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            // 07 de Julio del 2025: Si es compatible, se usa.
            return supportedLocale;
          }
        }

        // 07 de Julio del 2025: Prioridad 3: Usar el primer idioma de la lista como fallback.
        // Si el idioma del dispositivo no está soportado, se usa el primer idioma de la
        // lista (en este caso, 'en' - inglés) como idioma por defecto.
        return supportedLocales.first;
      },

      home: const TaskScreen(),
    );
  }
}
