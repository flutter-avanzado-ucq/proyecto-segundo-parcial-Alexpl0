## Cambios recientes y explicación

### 1. Persistencia con Hive
- **Archivos modificados:**  
  - `lib/main.dart`  
  - `lib/provider_task/task_provider.dart`  
  - `lib/models/task_model.dart`  
- **¿Qué se hizo?**  
  Se integró Hive para almacenar las tareas localmente. Se inicializa Hive al arrancar la app y se usa un `TaskProvider` que gestiona la caja de tareas (`tasksBox`).  
- **¿Para qué?**  
  Para que las tareas persistan aunque se cierre la app.

### 2. Notificaciones locales (inmediatas y programadas)
- **Archivos modificados:**  
  - `lib/services/notification_service.dart`  
  - `lib/widgets/add_task_sheet.dart`  
  - `lib/widgets/edit_task_sheet.dart`  
- **¿Qué se hizo?**  
  Se agregó un servicio para mostrar notificaciones inmediatas al crear/editar tareas y programadas para recordar tareas en una fecha/hora específica.  
- **¿Para qué?**  
  Para avisar al usuario cuando crea, edita o debe recordar una tarea.

### 3. Animaciones y mejoras visuales
- **Archivos modificados:**  
  - `lib/screens/tarea_screen.dart`  
  - `lib/widgets/card_tarea.dart`  
- **¿Qué se hizo?**  
  Se mejoró la visualización de la lista de tareas con animaciones y se actualizó el diseño de las tarjetas de tarea, mostrando fecha y hora de vencimiento.  
- **¿Para qué?**  
  Para una mejor experiencia visual y de usuario.

### 4. Edición y eliminación de tareas
- **Archivos modificados:**  
  - `lib/widgets/card_tarea.dart`  
  - `lib/widgets/edit_task_sheet.dart`  
  - `lib/provider_task/task_provider.dart`  
- **¿Qué se hizo?**  
  Se permite editar y eliminar tareas, actualizando/cancelando notificaciones asociadas.  
- **¿Para qué?**  
  Para que el usuario pueda gestionar completamente sus tareas.

**Última actualización:**