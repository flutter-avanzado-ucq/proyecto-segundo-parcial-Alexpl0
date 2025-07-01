import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';
import 'package:provider/provider.dart';
import 'provider_task/task_provider.dart';
import 'provider_task/theme_provider.dart'; // 30 de Junio, se agrega para el manejo del tema (oscuro/claro)

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
    MultiProvider( // 30 de Junio, se cambia ChangeNotifierProvider por MultiProvider para soportar múltiples providers
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // 30 de Junio, se agrega ThemeProvider para el tema dinámico
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>( // 30 de Junio, se usa Consumer para escuchar cambios en el tema
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tareas Pro',
          theme: AppTheme.theme,
          darkTheme: ThemeData.dark(), // 30 de Junio, se agrega soporte para tema oscuro
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light, // 30 de Junio, cambia el tema según el provider
          home: const TaskScreen(),
        );
      },
    );
  }
}
