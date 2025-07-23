# Tareas Pro - Informe de Actualización

## Informe de Actualización del Proyecto - 22 de julio de 2025

### Resumen General de la Actualización
El objetivo de esta actualización fue enriquecer la experiencia del usuario mediante la integración de una API externa para mostrar información del clima en tiempo real. Se ha implementado la capacidad de consumir datos de la API de OpenWeatherMap, presentando de forma dinámica la temperatura y el estado del tiempo actual directamente en el encabezado de la aplicación. Esta funcionalidad añade un contexto ambiental útil para el usuario al momento de revisar sus tareas.

---

### Nuevas Funcionalidades Implementadas

#### Visualización del Clima en el Encabezado (Header)
- **Información Dinámica:** El Header de la aplicación ahora muestra la temperatura actual (°C), un ícono representativo del clima (sol, nubes, lluvia, etc.) y una breve descripción textual (ej. "Nubes dispersas").
- **Datos Geolocalizados (Fijos):** Para esta práctica, la información del clima corresponde a una ubicación fija (Querétaro, México), establecida mediante coordenadas geográficas.
- **Manejo de Estados de UI:** La interfaz proporciona retroalimentación visual al usuario durante todo el proceso:
  - **Estado de Carga:** Muestra un indicador de progreso circular mientras se obtienen los datos de la API.
  - **Estado de Éxito:** Presenta la información del clima de forma clara y elegante.
  - **Estado de Error:** Si la petición a la API falla (por falta de conexión, etc.), se muestra un mensaje de error descriptivo.

---

### Detalles Técnicos de la Implementación

La arquitectura de la solución se ha estructurado en tres capas principales: Capa de Servicio (para la comunicación con la API), Capa de Estado (para la gestión de los datos) y Capa de UI (para la presentación).

#### 1. Configuración del Proyecto
- **Dependencia HTTP (`pubspec.yaml`):** Se añadió el paquete oficial `http` a las dependencias. Este paquete es la herramienta que permite a la aplicación realizar peticiones HTTP (GET, POST, etc.) a servidores externos.
- **Permiso de Internet (`AndroidManifest.xml`):** Se agregó el permiso `<uses-permission android:name="android.permission.INTERNET"/>` al manifiesto de Android. Este es un requisito indispensable del sistema operativo para permitir que la app acceda a la red.

#### 2. Capa de Servicio (`weather_service.dart`)
- **Archivo Creado:** `lib/services/weather_service.dart`
- **Clase `WeatherData`:** Se creó una clase modelo para mapear la respuesta JSON de la API a un objeto Dart fuertemente tipado. Esto facilita el manejo de los datos y previene errores. Contiene los campos: `description`, `temperature`, `cityName`, y `iconCode`.
- **Clase `WeatherService`:** Encapsula toda la lógica de la petición a la API. Su método `fetchWeatherByLocation` construye la URL con los parámetros necesarios (coordenadas, API Key, unidades, idioma) y ejecuta la petición `http.get()`. Gestiona la respuesta y, si es exitosa (código 200), decodifica el JSON y lo convierte en un objeto `WeatherData`.

#### 3. Capa de Gestión de Estado (`weather_provider.dart`)
- **Archivo Creado:** `lib/provider_task/weather_provider.dart`
- **Clase `WeatherProvider`:** Utilizando el patrón `ChangeNotifier` y el paquete `provider`, esta clase actúa como el cerebro de la funcionalidad.
  - **Manejo de Estado:** Contiene las variables que representan el estado actual: `_isLoading`, `_errorMessage` y `_weatherData`.
  - **Orquestación:** Su método `loadWeather` es invocado por la UI. Este método actualiza el estado a "cargando", llama al `WeatherService` para obtener los datos, y actualiza el estado final con los datos del clima o con un mensaje de error.
  - **Notificación a la UI:** Llama a `notifyListeners()` cada vez que el estado cambia, provocando que los widgets que estén "escuchando" se reconstruyan automáticamente.

#### 4. Integración en la Interfaz de Usuario (UI)
- **`main.dart`:** Se registró el `WeatherProvider` en el `MultiProvider` al inicio de la aplicación. Esto lo hace accesible desde cualquier parte del árbol de widgets, asegurando una única instancia global para gestionar el estado del clima.
- **`lib/screens/tarea_screen.dart`:** En el método `initState` de esta pantalla, se realiza la llamada inicial a `context.read<WeatherProvider>().loadWeather(...)`. Esto dispara la carga de los datos del clima tan pronto como el usuario abre la aplicación. Se utiliza `context.read` porque solo se necesita invocar el método, sin necesidad de redibujar esta pantalla con los cambios.
- **`lib/widgets/header.dart`:** Este es el widget que presenta la información.
  - Utiliza `context.watch<WeatherProvider>()` para suscribirse a los cambios del provider.
  - Implementa una lógica de renderizado condicional: si `isLoading` es true, muestra un `CircularProgressIndicator`. Si `errorMessage` no es nulo, muestra el error. Si `weatherData` tiene datos, construye y muestra la fila con el ícono, la temperatura y la descripción del clima.

---

### Archivos Afectados por la Actualización

**Creados:**
- `lib/services/weather_service.dart`
- `lib/provider_task/weather_provider.dart`

**Modificados:**
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- `lib/main.dart`
- `lib/screens/tarea_screen.dart`
- `lib/widgets/header.dart`

---

**Última actualización:** 22 de julio,