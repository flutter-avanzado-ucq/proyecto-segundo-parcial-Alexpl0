// 07 de Julio del 2025: Archivo creado para la pantalla de configuración de idioma.
// Esta pantalla permite seleccionar entre los idiomas disponibles (español e inglés)
// o volver a usar la configuración de idioma del sistema operativo.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 07 de Julio del 2025: Se importa el archivo de localizaciones generado automáticamente.
// Esto da acceso a las traducciones de la app, como el título del AppBar.
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
// 07 de Julio del 2025: Se importa el LocaleProvider para poder interactuar con él.
import '../provider_task/locale_provider.dart';

// 07 de Julio del 2025: Definición del widget para la pantalla de ajustes.
// Es un StatelessWidget porque su estado es manejado externamente por el LocaleProvider.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 07 de Julio del 2025: Obtiene la instancia de LocaleProvider del árbol de widgets.
    // 'Provider.of<LocaleProvider>(context)' busca hacia arriba en el árbol de widgets
    // hasta encontrar el LocaleProvider registrado en main.dart.
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      // 07 de Julio del 2025: El AppBar muestra el título de la app en el idioma actual.
      // 'AppLocalizations.of(context)!.appTitle' obtiene la traducción de 'appTitle'.
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
      ),
      // 07 de Julio del 2025: Usa un ListView para mostrar las opciones de idioma.
      body: ListView(
        children: [
          // 07 de Julio del 2025: Opción para seleccionar 'Español'.
          ListTile(
            title: const Text('Español'),
            // 07 de Julio del 2025: Muestra un ícono de 'check' si el español es el idioma activo.
            // Compara el 'languageCode' del locale actual del provider con 'es'.
            trailing: localeProvider.locale?.languageCode == 'es'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            // 07 de Julio del 2025: Al tocar esta opción...
            onTap: () {
              // 07 de Julio del 2025: ...llama a setLocale en el provider con el código 'es'.
              localeProvider.setLocale(const Locale('es'));
              // 07 de Julio del 2025: Cierra la pantalla de ajustes.
              Navigator.pop(context);
            },
          ),
          // 07 de Julio del 2025: Opción para seleccionar 'English'.
          ListTile(
            title: const Text('English'),
            // 07 de Julio del 2025: Muestra un ícono de 'check' si el inglés es el idioma activo.
            trailing: localeProvider.locale?.languageCode == 'en'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              // 07 de Julio del 2025: Llama a setLocale con el código 'en'.
              localeProvider.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          // 07 de Julio del 2025: Opción para usar el idioma del sistema.
          ListTile(
            title: const Text('Usar idioma del sistema'),
            // 07 de Julio del 2025: Muestra el 'check' si el locale en el provider es nulo.
            // La lógica en LocaleProvider establece 'null' para usar el idioma del sistema.
            trailing: localeProvider.locale == null
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              // 07 de Julio del 2025: Llama a clearLocale para borrar la preferencia guardada.
              localeProvider.clearLocale();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
