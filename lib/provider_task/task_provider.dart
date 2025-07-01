import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';
import '../services/notification_service.dart';

class TaskProvider with ChangeNotifier {
  Box<Task> get _taskBox => Hive.box<Task>('tasksBox');

  List<Task> get tasks => _taskBox.values.toList();

  void addTask(String title, {DateTime? dueDate, TimeOfDay? dueTime, int? notificationId}) async {
    final task = Task(
      title: title,
      dueDate: dueDate,
      notificationId: notificationId,
    );
    await _taskBox.add(task);
    notifyListeners();
  }

  void toggleTask(int index) async {
    final task = _taskBox.getAt(index);
    if (task != null) {
      task.done = !task.done;
      await task.save();
      notifyListeners();
    }
  }

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
