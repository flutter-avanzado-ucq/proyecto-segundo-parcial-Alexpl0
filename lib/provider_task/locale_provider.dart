// 07 de Julio del 2025: Archivo creado para gestionar el estado del idioma en la aplicación.
// Este provider se encargará de cambiar el idioma, guardar la preferencia del usuario en el
// dispositivo y notificar a la aplicación cuando el idioma cambie para que la interfaz de
// usuario se reconstruya con las traducciones correctas.

import 'package:flutter/material.dart';
// 07 de Julio del 2025: ¡CORRECCIÓN! Se añade la importación para SharedPreferences.
// Esta línea soluciona el error 'Undefined name SharedPreferences'.
// Indica a Dart dónde encontrar la clase SharedPreferences y sus métodos.
import 'package:shared_preferences/shared_preferences.dart';

// 07 de Julio del 2025: Definición de la clase LocaleProvider.
// Utiliza 'with ChangeNotifier' para poder notificar a sus 'listeners' (los widgets que
// estén escuchando este provider) sobre cualquier cambio en sus datos. Esto es fundamental
// para que la UI se actualice automáticamente cuando se seleccione un nuevo idioma.
class LocaleProvider with ChangeNotifier {
  // 07 de Julio del 2025: Variable privada para almacenar el idioma (Locale) actual.
  // Un objeto 'Locale' en Flutter representa una región geográfica y lingüística específica.
  // Puede ser nulo, lo que significa que la app usará el idioma del sistema operativo.
  Locale? _locale;

  // 07 de Julio del 2025: Getter público para acceder al idioma actual.
  // Los widgets podrán leer el valor de '_locale' a través de esta propiedad.
  Locale? get locale => _locale;

  // 07 de Julio del 2025: Constructor de la clase.
  // Cuando se crea una instancia de LocaleProvider, inmediatamente llama a _loadLocale
  // para cargar el idioma que se haya guardado previamente.
  LocaleProvider() {
    _loadLocale();
  }

  // 07 de Julio del 2025: Método privado para cargar la preferencia de idioma.
  // Este método es asíncrono (Future<void>) porque la lectura de SharedPreferences
  // es una operación que no se completa instantáneamente.
  Future<void> _loadLocale() async {
    // 07 de Julio del 2025: Obtiene una instancia de SharedPreferences.
    // SharedPreferences es un mecanismo para guardar datos simples (clave-valor) de forma
    // persistente en el dispositivo.
    final prefs = await SharedPreferences.getInstance();

    // 07 de Julio del 2025: Lee el código de idioma guardado con la clave 'langCode'.
    final langCode = prefs.getString('langCode');

    // 07 de Julio del 2025: Si se encontró un código de idioma...
    if (langCode != null) {
      // 07 de Julio del 2025: ...crea un objeto Locale con ese código...
      _locale = Locale(langCode);
      // 07 de Julio del 2025: ...y notifica a los listeners para que la UI se actualice.
      notifyListeners();
    }
  }

  // 07 de Julio del 2025: Método público para establecer un nuevo idioma.
  // Recibe un objeto 'Locale' como parámetro.
  Future<void> setLocale(Locale locale) async {
    // 07 de Julio del 2025: Actualiza la variable interna con el nuevo idioma.
    _locale = locale;

    // 07 de Julio del 2025: Guarda el nuevo código de idioma en SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', locale.languageCode);

    // 07 de Julio del 2025: Notifica a los listeners para que la app se redibuje con el nuevo idioma.
    notifyListeners();
  }

  // 07 de Julio del 2025: Método para limpiar la preferencia de idioma.
  // Esto hará que la aplicación vuelva a usar el idioma por defecto del sistema.
  void clearLocale() async {
    // 07 de Julio del 2025: Establece el locale a nulo.
    _locale = null;

    // 07 de Julio del 2025: Elimina la clave 'langCode' de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('langCode');

    // 07 de Julio del 2025: Notifica a los listeners del cambio.
    notifyListeners();
  }
}
