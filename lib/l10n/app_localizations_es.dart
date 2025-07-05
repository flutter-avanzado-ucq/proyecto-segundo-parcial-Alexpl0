// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tareas Pro';

  @override
  String get addTask => 'Agregar tarea';

  @override
  String get editTask => 'Editar tarea';

  @override
  String get deleteTask => 'Eliminar tarea';

  @override
  String get changeTheme => 'Cambiar tema';

  @override
  String get addNewTask => 'Agregar nueva tarea';

  @override
  String get description => 'Descripción';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get selectTime => 'Seleccionar hora';

  @override
  String get timeLabel => 'Hora:';

  @override
  String get dueDate => 'Vence:';

  @override
  String get hourLabel => 'Hora:';

  @override
  String get titleLabel => 'Título';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get greeting => 'Hola, Alex 👋';

  @override
  String get todayTasks => 'Estas son tus tareas para hoy';

  @override
  String get name => 'nombre';

  @override
  String get changeDate => 'Cambiar fecha';

  @override
  String get changeTime => 'Cambiar hora';

  @override
  String get editTaskTitle => 'Editar Tarea';

  @override
  String get selectDateButton => 'Selecciona una fecha';

  @override
  String get appBarTitle => 'Mis Tareas';

  @override
  String get notificationTaskUpdatedTitle => 'Tarea actualizada';

  @override
  String notificationTaskUpdatedBody(String taskName) {
    return 'Has actualizado la tarea: $taskName';
  }

  @override
  String get notificationReminderTaskUpdatedTitle =>
      'Recordatorio de tarea actualizada';

  @override
  String notificationReminderTaskUpdatedBody(String taskName) {
    return 'No olvides: $taskName';
  }

  @override
  String get notificationNewTaskTitle => 'Nueva tarea';

  @override
  String notificationNewTaskBody(String taskName) {
    return 'Has agregado la tarea: $taskName';
  }

  @override
  String get notificationReminderTaskTitle => 'Recordatorio de tarea';

  @override
  String notificationReminderTaskBody(String taskName) {
    return 'No olvides: $taskName';
  }
}
