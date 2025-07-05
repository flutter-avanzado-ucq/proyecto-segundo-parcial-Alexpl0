import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';
import '../services/notification_service.dart';

class TaskProvider with ChangeNotifier {
  // Obtiene la caja de Hive para las tareas
  Box<Task> get _taskBox => Hive.box<Task>('tasksBox');

  // Obtiene la lista de tareas desde la caja
  List<Task> get tasks => _taskBox.values.toList();

  // La función para combinar fecha y hora ha sido eliminada para simplificar.
  // La UI ahora es responsable de pasar el objeto DateTime final.

  // Agrega una nueva tarea. La firma del método ha sido simplificada.
  void addTask(String title, {DateTime? dueDate, int? notificationId}) async {
    final task = Task(
      title: title,
      dueDate: dueDate, // Se usa directamente el valor que llega.
      notificationId: notificationId,
    );

    await _taskBox.add(task); // Guarda la tarea en Hive.

    // La lógica para programar notificaciones se ha eliminado de aquí.
    // La pantalla 'add_task_sheet.dart' ya se encarga de esto.

    notifyListeners(); // Notifica a los widgets dependientes para que se actualicen.
  }

  // Cambia el estado de completado de una tarea
  void toggleTask(int index) async {
    if (index >= 0 && index < _taskBox.length) {
      final task = _taskBox.getAt(index);
      if (task != null) {
        task.done = !task.done; // Cambia el estado de completado
        await task.save(); // Guarda los cambios en Hive
        notifyListeners(); // Notifica a los widgets dependientes
      }
    }
  }

  // Elimina una tarea
  void removeTask(int index) async {
    if (index >= 0 && index < _taskBox.length) {
      final task = _taskBox.getAt(index);
      if (task != null) {
        // Cancela la notificación asociada, si existe
        if (task.notificationId != null) {
          await NotificationService.cancelNotification(task.notificationId!);
        }
        await task.delete(); // Elimina la tarea de Hive
        notifyListeners(); // Notifica a los widgets dependientes
      }
    }
  }

  // Actualiza una tarea existente. La firma del método ha sido simplificada.
  void updateTask(int index, String newTitle, {DateTime? newDate, int? notificationId}) async {
    if (index >= 0 && index < _taskBox.length) {
      final task = _taskBox.getAt(index);
      if (task != null) {
        // La pantalla 'edit_task_sheet.dart' ya se encarga de cancelar la
        // notificación anterior y programar la nueva.

        // Actualiza los datos de la tarea
        task.title = newTitle;
        task.dueDate = newDate; // Se usa directamente el nuevo valor de fecha/hora.
        task.notificationId = notificationId;
        await task.save(); // Guarda los cambios en Hive

        notifyListeners(); // Notifica a los widgets dependientes
      }
    }
  }
}
