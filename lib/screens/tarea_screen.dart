import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../widgets/card_tarea.dart';
import '../widgets/header.dart';
import '../widgets/add_task_sheet.dart';
import '../provider_task/task_provider.dart';
import '../provider_task/theme_provider.dart';
// 21 de julio: AÑADIDO - Importación del WeatherProvider.
// Al igual que en main.dart, necesitamos importar el provider aquí para poder interactuar con él,
// específicamente para poder llamar al método que carga la información del clima.
import '../provider_task/weather_provider.dart';

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
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Pro'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                tooltip: 'Cambiar tema',
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
          children: [
            const Header(),
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
