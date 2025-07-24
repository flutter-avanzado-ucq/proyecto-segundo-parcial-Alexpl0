import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';
import 'provider_task/task_provider.dart';
import 'provider_task/theme_provider.dart';
// Importación del WeatherProvider.
import 'provider_task/weather_provider.dart';
// 23 de julio: AÑADIDO - Importación del HolidayProvider.
// De la misma manera que registramos los otros providers, necesitamos importar
// el nuevo HolidayProvider para poder añadirlo al MultiProvider y que sea
// accesible desde cualquier parte de nuestra aplicación.
import 'provider_task/holiday_provider.dart';
import 'models/task_model.dart';
import 'services/notification_service.dart';

// Importaciones para la internacionalización.
// 'app_localizations.dart' es la clase principal generada por Flutter para manejar las traducciones.
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
// 'flutter_localizations.dart' provee los delegados necesarios para que los widgets de Flutter (Material, Cupertino) se traduzcan.
import 'package:flutter_localizations/flutter_localizations.dart';
import 'provider_task/locale_provider.dart';

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
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        // 23 de julio: AÑADIDO - Registro del HolidayProvider.
        // Siguiendo el patrón de la práctica anterior, añadimos el HolidayProvider a nuestra
        // lista de providers globales.
        //
        // ¿Qué hace esta línea?
        // 1. `ChangeNotifierProvider`: Es un widget de la librería `provider` que crea y
        //    provee una instancia de un `ChangeNotifier` a sus descendientes.
        // 2. `create: (_) => HolidayProvider()`: Esta es la función factory que se encarga
        //    de construir la instancia de nuestro `HolidayProvider`. Se ejecutará de forma
        //    "lazy" (perezosa), es decir, la primera vez que un widget intente acceder a él.
        //
        // ¿Por qué aquí?
        // Al colocarlo en el `MultiProvider` al inicio de la aplicación (en `main.dart`),
        // nos aseguramos de que una ÚNICA instancia de `HolidayProvider` esté disponible
        // para cualquier widget en el árbol, como `TaskScreen`, `Header` o `TaskCard`.
        // Esto centraliza el estado de los feriados y la lógica para obtenerlos, manteniendo
        // nuestro código limpio, organizado y eficiente.
        ChangeNotifierProvider(create: (_) => HolidayProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      theme: AppTheme.theme,
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      locale: localeProvider.locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // Inglés
        Locale('es'), // Español
      ],

      localeResolutionCallback: (locale, supportedLocales) {
        if (localeProvider.locale != null) {
          return localeProvider.locale;
        }

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },

      home: const TaskScreen(),
    );
  }
}
