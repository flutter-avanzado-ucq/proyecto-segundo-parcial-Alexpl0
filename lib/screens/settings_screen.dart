import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animaciones_notificaciones/l10n/app_localizations.dart';
import '../provider_task/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 23 de julio: OBTENCIÓN DE PROVIDER Y LOCALIZACIONES
    // Obtenemos las instancias necesarias.
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        // 23 de julio: TRADUCCIÓN AÑADIDA
        // Usamos la clave `language` para el título del AppBar.
        title: Text(localizations.language),
      ),
      body: ListView(
        children: [
          ListTile(
            // 23 de julio: TRADUCCIÓN AÑADIDA
            title: Text(localizations.spanish),
            trailing: localeProvider.locale?.languageCode == 'es'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              localeProvider.setLocale(const Locale('es'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            // 23 de julio: TRADUCCIÓN AÑADIDA
            title: Text(localizations.english),
            trailing: localeProvider.locale?.languageCode == 'en'
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              localeProvider.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            // 23 de julio: TRADUCCIÓN AÑADIDA
            title: Text(localizations.systemLanguage),
            trailing: localeProvider.locale == null
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              localeProvider.clearLocale();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
