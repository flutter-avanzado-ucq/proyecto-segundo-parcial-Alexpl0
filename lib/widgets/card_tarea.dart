import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
// 23 de julio: AÑADIDO - Importación del HolidayProvider.
// Necesitamos acceder a la lista de feriados para poder compararla con la
// fecha de vencimiento de la tarea.
import '../provider_task/holiday_provider.dart';
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
    final localizations = AppLocalizations.of(context)!;

    // 23 de julio: AÑADIDO - Lógica para verificar si la fecha de la tarea es un feriado.
    //
    // 1. `context.watch<HolidayProvider>().holidays`: Usamos `watch` para obtener la lista
    //    de feriados. Esto asegura que si la lista cambia (por ejemplo, al cargar por
    //    primera vez), el widget se reconstruirá para re-evaluar si la tarea es un feriado.
    //    Guardamos la lista en la variable `holidays`.
    final holidays = context.watch<HolidayProvider>().holidays;

    // 2. `isHoliday`: Esta variable booleana contendrá el resultado de nuestra verificación.
    //    La lógica es la siguiente:
    bool isHoliday = false; // Por defecto, no es feriado.

    // Primero, nos aseguramos de que tanto la fecha de vencimiento (`dueDate`) como la lista
    // de feriados (`holidays`) no sean nulas. Si alguna de las dos falta, no podemos hacer
    // la comparación.
    if (dueDate != null && holidays != null) {
      // `holidays.any((holiday) => ...)`: Este es un método muy útil de las listas en Dart.
      // Recorre cada elemento (`holiday`) de la lista `holidays` y ejecuta la función
      // que le pasamos. Devuelve `true` tan pronto como encuentra un elemento que cumple
      // la condición, y `false` si ninguno la cumple.
      isHoliday = holidays.any((holiday) {
        // La condición compara el año, mes y día de la fecha del feriado con la fecha
        // de vencimiento de la tarea. Si los tres coinciden, significa que la tarea
        // vence en un día feriado, y `.any` devolverá `true`.
        return holiday.date.year == dueDate!.year &&
               holiday.date.month == dueDate!.month &&
               holiday.date.day == dueDate!.day;
      });
    }

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
                  child: Wrap( // Usamos Wrap para que los elementos se ajusten si no caben
                    spacing: 8.0, // Espacio horizontal entre la fecha y la etiqueta de feriado
                    runSpacing: 4.0, // Espacio vertical si se van a una nueva línea
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          final locale = Localizations.localeOf(context).languageCode;
                          final formattedDate = DateFormat.yMMMMd(locale).format(dueDate!);
                          final translatedDueDate = localizations.dueDate(formattedDate);
                          
                          return Text(
                            translatedDueDate,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        },
                      ),
                      // 23 de julio: AÑADIDO - Etiqueta de feriado condicional.
                      // Al igual que en el Header, usamos un `if` en la lista de widgets.
                      // Si nuestra variable `isHoliday` es `true`, se añadirá este widget
                      // `Text` a la `Wrap`, mostrando la etiqueta "Feriado".
                      // Si es `false`, simplemente no se añade nada.
                      if (isHoliday)
                        Text(
                          '(${localizations.holidayTag})', // Usamos la clave de traducción
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
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
