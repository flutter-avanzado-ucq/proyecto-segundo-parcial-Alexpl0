import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// 07 de Julio del 2025: Se importan las localizaciones para acceder a los textos traducidos.
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
import '../widgets/edit_task_sheet.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Animation<double> iconRotation;
  final DateTime? dueDate;
  final int index;

  const TaskCard({
    super.key,
    required this.title,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
    required this.iconRotation,
    required this.index,
    this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    // 07 de Julio del 2025: Se obtiene la instancia de las localizaciones para este contexto.
    final localizations = AppLocalizations.of(context)!;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isDone ? 0.4 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDone ? const Color(0xFFD0F0C0) : const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedBuilder(
              animation: iconRotation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: iconRotation.value * pi,
                  child: Icon(
                    isDone ? Icons.refresh : Icons.radio_button_unchecked,
                    color: isDone ? Colors.teal : Colors.grey,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  fontSize: 18,
                  color: isDone ? Colors.black45 : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (dueDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  // 07 de Julio del 2025: Se reemplaza la forma de mostrar la fecha.
                  // En lugar de un Text simple, se usa un Builder para acceder al contexto
                  // más cercano y obtener el 'locale' actual para formatear la fecha.
                  child: Builder(
                    builder: (context) {
                      // 07 de Julio del 2025: Se obtiene el código de idioma del contexto actual.
                      // Ej: 'es' para español, 'en' para inglés.
                      final locale = Localizations.localeOf(context).languageCode;
                      
                      // 07 de Julio del 2025: Se formatea la fecha usando el paquete 'intl'.
                      // 'yMMMMd' es un formato esqueleto que 'intl' adapta al 'locale'.
                      // Para 'es', será algo como "7 de julio de 2025".
                      // Para 'en', será "July 7, 2025".
                      final formattedDate = DateFormat.yMMMMd(locale).format(dueDate!);
                      
                      // 07 de Julio del 2025: Se usa la función de localización 'dueDate'.
                      // Esta función toma la fecha ya formateada y la inserta en el placeholder
                      // definido en los archivos .arb ("Vence el {date}" o "Due on {date}").
                      final translatedDueDate = localizations.dueDate(formattedDate);
                      
                      // 07 de Julio del 2025: Finalmente, se muestra el texto completamente localizado.
                      return Text(
                        translatedDueDate,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      );
                    },
                  ),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => EditTaskSheet(index: index),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
