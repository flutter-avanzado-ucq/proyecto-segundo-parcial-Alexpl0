import 'package:flutter/material.dart';
// 26/06/2025: Integración Hive: importación de Hive y modelo Task
import 'package:hive/hive.dart';
import '../models/task_model.dart';
import '../services/notification_service.dart';

// 26/06/2025: Integración Hive: TaskProvider ahora usa Hive para persistencia
class TaskProvider with ChangeNotifier {
  // 26/06/2025: Integración Hive: acceso a la caja tasksBox
  Box<Task> get _taskBox => Hive.box<Task>('tasksBox');

  // 26/06/2025: Integración Hive: obtención de tareas desde Hive
  List<Task> get tasks => _taskBox.values.toList();

  // 26/06/2025: Integración Hive: creación y almacenamiento de tarea en Hive
  void addTask(String title, {DateTime? dueDate, TimeOfDay? dueTime, int? notificationId}) async {
    final task = Task(
      title: title,
      dueDate: dueDate,
      notificationId: notificationId,
    );
    await _taskBox.add(task);
    notifyListeners();
  }

  // 26/06/2025: Integración Hive: actualización de estado en Hive
  void toggleTask(int index) async {
    final task = _taskBox.getAt(index);
    if (task != null) {
      task.done = !task.done;
      await task.save();
      notifyListeners();
    }
  }

  // 26/06/2025: Integración Hive: eliminación de tarea en Hive
  void removeTask(int index) async {
    final task = _taskBox.getAt(index);
    if (task != null) {
      if (task.notificationId != null) {
        await NotificationService.cancelNotification(task.notificationId!);
      }
      await task.delete();
      notifyListeners();
    }
  }

  // 26/06/2025: Integración Hive: actualización de campos en tarea almacenada en Hive
  void updateTask(int index, String newTitle, {DateTime? newDate, TimeOfDay? newTime, int? notificationId}) async {
    final task = _taskBox.getAt(index);
    if (task != null) {
      if (task.notificationId != null) {
        await NotificationService.cancelNotification(task.notificationId!);
      }
      task.title = newTitle;
      task.dueDate = newDate;
      task.notificationId = notificationId;
      await task.save();
      notifyListeners();
    }
  }
}
