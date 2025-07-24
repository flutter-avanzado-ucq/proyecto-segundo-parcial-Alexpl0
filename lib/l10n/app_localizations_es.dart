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
  String get hourLabel => 'Hora:';

  @override
  String get titleLabel => 'Título';

  @override
  String get saveChanges => 'Guardar cambios';

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
  String notificationTaskUpdatedBody(Object taskName) {
    return 'Has actualizado la tarea: $taskName';
  }

  @override
  String get notificationReminderTaskUpdatedTitle =>
      'Recordatorio de tarea actualizada';

  @override
  String notificationReminderTaskUpdatedBody(Object taskName) {
    return 'No olvides: $taskName';
  }

  @override
  String get notificationNewTaskTitle => 'Nueva tarea';

  @override
  String notificationNewTaskBody(Object taskName) {
    return 'Has agregado la tarea: $taskName';
  }

  @override
  String get notificationReminderTaskTitle => 'Recordatorio de tarea';

  @override
  String notificationReminderTaskBody(Object taskName) {
    return 'No olvides: $taskName';
  }

  @override
  String get language => 'Idioma';

  @override
  String dueDate(String date) {
    return 'Vence el $date';
  }

  @override
  String pendingTasks(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $countString tareas pendientes',
      one: 'Tienes 1 tarea pendiente',
      zero: 'No tienes tareas pendientes',
    );
    return '$_temp0';
  }

  @override
  String get todayIsHoliday => 'Hoy es feriado';

  @override
  String get holidayTag => 'Feriado';

  @override
  String greeting(String userName) {
    return 'Hola, $userName 👋';
  }

  @override
  String get todayTasksHeader => 'Estas son tus tareas para hoy';

  @override
  String get weatherError => 'No se pudo cargar la información del clima';

  @override
  String get weatherLoading => 'Cargando clima...';

  @override
  String get holidayError => 'No se pudieron cargar los feriados';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get systemLanguage => 'Usar idioma del sistema';
}
