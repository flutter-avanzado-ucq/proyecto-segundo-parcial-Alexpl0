import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_task/task_provider.dart';
import '../services/notification_service.dart';
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart'; //05 de julio: se agregó soporte para localización

class EditTaskSheet extends StatefulWidget {
  final int index;

  const EditTaskSheet({super.key, required this.index});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  late TextEditingController _controller;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    final task = Provider.of<TaskProvider>(context, listen: false).tasks[widget.index];
    _controller = TextEditingController(text: task.title);
    _selectedDate = task.dueDate;

    if (task.dueDate != null) {
      _selectedTime = TimeOfDay.fromDateTime(task.dueDate!);
    } else {
      _selectedTime = const TimeOfDay(hour: 8, minute: 0);
    }
  }

  void _submit() async {
    final localizations = AppLocalizations.of(context)!; //05 de julio: se agregó soporte para traducciones
    final newTitle = _controller.text.trim();
    if (newTitle.isNotEmpty) {
      int? notificationId;
      DateTime? finalDueDate;

      final task = Provider.of<TaskProvider>(context, listen: false).tasks[widget.index];

      if (task.notificationId != null) {
        await NotificationService.cancelNotification(task.notificationId!);
      }

      //05 de julio: se agregó traducción al título y cuerpo de la notificación
      await NotificationService.showImmediateNotification(
        title: localizations.notificationTaskUpdatedTitle,
        body: localizations.notificationTaskUpdatedBody(newTitle), //05 de julio: se agregó parámetro dinámico al cuerpo
        payload: 'Tarea actualizada: $newTitle',
      );

      if (_selectedDate != null && _selectedTime != null) {
        finalDueDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

        //05 de julio: se agregó traducción al título y cuerpo del recordatorio
        await NotificationService.scheduleNotification(
          title: localizations.notificationReminderTaskUpdatedTitle,
          body: localizations.notificationReminderTaskUpdatedBody(newTitle), //05 de julio: se agregó parámetro dinámico al cuerpo
          scheduledDate: finalDueDate,
          payload: 'Tarea actualizada: $newTitle para $finalDueDate',
          notificationId: notificationId,
        );
      }

      Provider.of<TaskProvider>(context, listen: false).updateTask(
        widget.index,
        newTitle,
        newDate: finalDueDate ?? _selectedDate,
        notificationId: notificationId,
      );

      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; //05 de julio: se agregó soporte para traducciones

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.editTaskTitle, //05 de julio: se agregó traducción al título
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: localizations.titleLabel, //05 de julio: se agregó traducción al label
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(localizations.changeDate), //05 de julio: se agregó traducción al botón de fecha
              ),
              const SizedBox(width: 10),
              if (_selectedDate != null)
                Text('${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: _pickTime,
                child: Text(localizations.changeTime), //05 de julio: se agregó traducción al botón de hora
              ),
              const SizedBox(width: 10),
              Text(localizations.timeLabel), //05 de julio: se agregó traducción al label de hora
              if (_selectedTime != null)
                Text('${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check),
            label: Text(localizations.saveChanges), //05 de julio: se agregó traducción al botón de guardar cambios
          ),
        ],
      ),
    );
  }
}
