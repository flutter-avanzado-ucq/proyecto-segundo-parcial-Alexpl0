import 'package:flutter/material.dart';
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart'; //05 de julio: se agregó soporte para localización

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; //05 de julio: se agregó localización para textos dinámicos

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)], // Cambiado a tonos azules
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pinimg.com/736x/63/bd/90/63bd905db1e3ea237a8c78e96ab562ab.jpg'), //05 de julio: se actualizó la imagen de avatar
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.greeting, //05 de julio: se agregó texto dinámico para el saludo
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                localizations.todayTasks, //05 de julio: se agregó texto dinámico para las tareas
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8), //05 de julio: espacio visual agregado
            ],
          ),
        ],
      ),
    );
  }
}
