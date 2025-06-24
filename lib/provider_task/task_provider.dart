import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class Task {
  String title;
  bool done;
  DateTime? dueDate;
  TimeOfDay? dueTime; // ✅ Manejo de la hora (dueTime) agregado aquí como parte del modelo de tarea.
  int? notificationId; // ✅ Identificador de notificación (notificationId) agregado aquí para asociar tareas con notificaciones específicas.

  Task({
    required this.title,
    this.done = false,
    this.dueDate,
    this.dueTime, // ✅ Se guarda la hora de vencimiento de la tarea.
    this.notificationId, // ✅ Se guarda el identificador único de la notificación.
  });
}

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title, {DateTime? dueDate, TimeOfDay? dueTime, int? notificationId}) {
    _tasks.insert(0, Task(
      title: title,
      dueDate: dueDate,
      dueTime: dueTime,
      notificationId: notificationId,
    ));
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].done = !_tasks[index].done;
    notifyListeners();
  }

  void removeTask(int index) {
    final task = _tasks[index];
    if (task.notificationId != null) {
      NotificationService.cancelNotification(task.notificationId!); // ✅ Cancelación de la notificación anterior al eliminar la tarea.
    }
    _tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, String newTitle, {DateTime? newDate, TimeOfDay? newTime, int? notificationId}) {
    final task = _tasks[index];

    if (task.notificationId != null) {
      NotificationService.cancelNotification(task.notificationId!); // ✅ Cancelación de la notificación anterior al actualizar la tarea.
    }

    _tasks[index].title = newTitle;
    _tasks[index].dueDate = newDate;
    _tasks[index].dueTime = newTime; // ✅ Actualización de la hora de vencimiento.
    _tasks[index].notificationId = notificationId; // ✅ Actualización del identificador de notificación.
    notifyListeners();
  }
}
