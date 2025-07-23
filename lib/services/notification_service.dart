import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    tz.initializeTimeZones();

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  static void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      print('Payload: ${response.payload}');
    }
  }

  static Future<void> requestPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      // Solicitar permiso básico de notificaciones
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      // En Android, solicitar permiso para alarmas exactas
      if (Platform.isAndroid) {
        if (await Permission.scheduleExactAlarm.isDenied) {
          await Permission.scheduleExactAlarm.request();
        }
      }

      // Solicitar permisos específicos para iOS
      if (Platform.isIOS) {
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      }
    }
  }

  static Future<void> showImmediateNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Notificaciones Instantáneas',
      channelDescription: 'Canal para notificaciones inmediatas',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    required int notificationId,
    String? payload,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) {
      print('La fecha y hora programadas ya pasaron. No se puede programar la notificación.');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Notificaciones Programadas',
      channelDescription: 'Canal para recordatorios de tareas',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
