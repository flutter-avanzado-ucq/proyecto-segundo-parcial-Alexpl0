// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Task Manager';

  @override
  String get addTask => 'Add task';

  @override
  String get editTask => 'Edit task';

  @override
  String get deleteTask => 'Delete task';

  @override
  String get changeTheme => 'Change theme';

  @override
  String get addNewTask => 'Add new task';

  @override
  String get description => 'Description';

  @override
  String get selectDate => 'Select date';

  @override
  String get selectTime => 'Select time';

  @override
  String get timeLabel => 'Time:';

  @override
  String get dueDate => 'Due:';

  @override
  String get hourLabel => 'Time:';

  @override
  String get titleLabel => 'Title';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get greeting => 'Hi, Alex 👋';

  @override
  String get todayTasks => 'These are your tasks for today';

  @override
  String get name => 'name';

  @override
  String get changeDate => 'Change date';

  @override
  String get changeTime => 'Change time';

  @override
  String get editTaskTitle => 'Edit Task';

  @override
  String get selectDateButton => 'Select a date';

  @override
  String get appBarTitle => 'My Tasks';

  @override
  String get notificationTaskUpdatedTitle => 'Task Updated';

  @override
  String notificationTaskUpdatedBody(String taskName) {
    return 'You have updated the task: $taskName';
  }

  @override
  String get notificationReminderTaskUpdatedTitle => 'Updated Task Reminder';

  @override
  String notificationReminderTaskUpdatedBody(String taskName) {
    return 'Don\'t forget: $taskName';
  }

  @override
  String get notificationNewTaskTitle => 'New Task';

  @override
  String notificationNewTaskBody(String taskName) {
    return 'You have added the task: $taskName';
  }

  @override
  String get notificationReminderTaskTitle => 'Task Reminder';

  @override
  String notificationReminderTaskBody(String taskName) {
    return 'Don\'t forget: $taskName';
  }
}
