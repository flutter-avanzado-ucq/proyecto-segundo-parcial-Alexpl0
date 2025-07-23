import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../widgets/card_tarea.dart';
import '../widgets/header.dart';
import '../widgets/add_task_sheet.dart';
import '../provider_task/task_provider.dart';
import '../provider_task/theme_provider.dart';
<<<<<<< HEAD
// 21 de julio: AÑADIDO - Importación del WeatherProvider.
// Al igual que en main.dart, necesitamos importar el provider aquí para poder interactuar con él,
// específicamente para poder llamar al método que carga la información del clima.
import '../provider_task/weather_provider.dart';
=======
// 07 de Julio del 2025: Se importan las localizaciones para acceder a los textos traducidos.
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
// 07 de Julio del 2025: Se importa la nueva pantalla de ajustes de idioma.
import 'settings_screen.dart';
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 21 de julio: AÑADIDO - Llamada para cargar los datos del clima.
    // Este bloque de código es el encargado de iniciar la petición a la API del clima
    // justo cuando la pantalla `TaskScreen` se construye por primera vez.
    //
    // ¿Por qué se hace de esta manera?
    //
    // 1. `initState()`: Este método es parte del ciclo de vida de un `StatefulWidget` y se
    //    llama una sola vez, cuando el widget se inserta en el árbol de widgets. Es el lugar
    //    perfecto para realizar inicializaciones, como suscripciones o, en este caso,
    //    peticiones a una API que solo necesitan hacerse una vez al cargar la pantalla.
    //
    // 2. `Future.microtask()`: Esta es una parte sutil pero importante. Llamar a `Provider`
    //    con `context` directamente dentro de `initState` puede causar errores porque, en ese
    //    preciso instante, el `context` del widget podría no estar completamente disponible
    //    en el árbol. `Future.microtask` agenda nuestra función para que se ejecute "un
    //    instante después", al final de la cola de microtareas, cuando podemos estar seguros
    //    de que el `context` es válido y está listo para ser usado.
    //
    // 3. `context.read<WeatherProvider>()`: Aquí estamos accediendo al `WeatherProvider` que
    //    registramos en `main.dart`. Usamos `.read()` en lugar de `.watch()` porque solo
    //    necesitamos obtener la instancia del provider para llamar a un método. No nos
    //    interesa "escuchar" cambios aquí, por lo tanto, no queremos que este widget se
    //    reconstruya si los datos del clima cambian. Simplemente queremos "dar la orden" de
    //    que se carguen los datos.
    //
    // 4. `.loadWeather(20.5888, -100.3899)`: Finalmente, llamamos al método que hemos creado
    //    en nuestro `WeatherProvider`. Le pasamos las coordenadas fijas de Querétaro, como
    //    se especificó en la práctica. Este método se encargará de hacer la petición HTTP,
    //    manejar la respuesta y notificar a cualquier widget que SÍ esté escuchando (con .watch())
    //    que los datos han cambiado.
    Future.microtask(() {
      context.read<WeatherProvider>().loadWeather(20.5888, -100.3899);
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddTaskSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 07 de Julio del 2025: Se obtiene la instancia del TaskProvider para acceder a la lista de tareas.
    final taskProvider = context.watch<TaskProvider>();
    // 07 de Julio del 2025: Se obtiene la instancia de las localizaciones para este contexto.
    // Esto permite llamar a métodos como 'localizations.appBarTitle'.
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Tareas Pro'),
        actions: [
=======
        // 07 de Julio del 2025: El título del AppBar ahora viene de las localizaciones.
        title: Text(localizations.appBarTitle),
        actions: [
          // 07 de Julio del 2025: Se añade un nuevo botón a la barra de acciones.
          // Este IconButton permite al usuario navegar a la pantalla de selección de idioma.
          IconButton(
            icon: const Icon(Icons.language),
            // 07 de Julio del 2025: El tooltip (texto que aparece al dejar presionado el botón)
            // también se obtiene de las localizaciones para que se traduzca.
            tooltip: localizations.language,
            onPressed: () {
              // 07 de Julio del 2025: Al presionar, se navega a la SettingsScreen.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
>>>>>>> 170cf56227f55a7b9c7a90fcddde0e7783534b7f
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                // 07 de Julio del 2025: El tooltip para cambiar tema también se localiza.
                tooltip: localizations.changeTheme,
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            // 07 de Julio del 2025: Se añade un texto para mostrar el conteo de tareas pendientes.
            // Este widget mostrará un mensaje que cambia según el número de tareas,
            // gracias a la pluralización definida en los archivos .arb.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                // 07 de Julio del 2025: Se llama a la función 'pendingTasks' generada.
                // Se le pasa el número total de tareas. Flutter se encargará de elegir
                // la cadena correcta ('=0', '=1', u 'other') según este valor.
                localizations.pendingTasks(taskProvider.tasks.length),
                // 07 de Julio del 2025: Se le da un estilo para que sea visible y consistente.
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.tasks[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 30.0,
                        child: FadeInAnimation(
                          child: Dismissible(
                            key: ValueKey(task.key),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => taskProvider.removeTask(index),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: TaskCard(
                              key: ValueKey(task.key),
                              title: task.title,
                              isDone: task.done,
                              dueDate: task.dueDate,
                              onToggle: () {
                                taskProvider.toggleTask(index);
                                _iconController.forward(from: 0);
                              },
                              onDelete: () => taskProvider.removeTask(index),
                              iconRotation: _iconController,
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.calendar_today),
      ),
    );
  }
}
