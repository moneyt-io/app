# Sistema de Copias de Seguridad

## 1. Objetivo

Implementar un sistema robusto y fácil de usar para que los usuarios de MoneyT puedan crear, gestionar y restaurar copias de seguridad de sus datos financieros, asegurando la protección contra pérdida de datos.

## 2. Requisitos

### 2.1. Funcionales

-   **Creación Manual:** Permitir al usuario crear una copia de seguridad en cualquier momento.
-   **Restauración Manual:** Permitir al usuario restaurar la base de datos desde un archivo de copia de seguridad seleccionado.
-   **Listado de Copias:** Mostrar una lista de las copias de seguridad disponibles, incluyendo metadatos (fecha, tamaño, versión de la app).
-   **Eliminación de Copias:** Permitir al usuario eliminar copias de seguridad específicas.
-   **Exportación/Compartir:** Permitir al usuario exportar o compartir un archivo de copia de seguridad.
-   **Importación:** Permitir al usuario importar un archivo de copia de seguridad desde el almacenamiento del dispositivo.
-   **(Opcional - Fase 2) Creación Automática:** Programar copias de seguridad automáticas (diarias/semanales).
-   **(Opcional - Fase 2) Configuración:** Permitir configurar la frecuencia, hora y política de retención de las copias automáticas.
-   **(Opcional - Fase 3) Cifrado:** Ofrecer cifrado opcional para los archivos de copia de seguridad.

### 2.2. No Funcionales

-   **Seguridad:** Proteger los datos durante el proceso de copia y restauración.
-   **Rendimiento:** Minimizar el impacto en el rendimiento de la aplicación durante las operaciones de copia/restauración.
-   **Usabilidad:** Interfaz intuitiva y clara para gestionar las copias.
-   **Confiabilidad:** Asegurar que las copias sean completas y restaurables.
-   **Compatibilidad:** Manejar posibles cambios en el esquema de la base de datos entre versiones de la aplicación.

## 3. Arquitectura y Componentes

El sistema seguirá la arquitectura limpia existente (Domain, Data, Presentation) y añadirá componentes específicos para la gestión de backups.

### 3.1. Capa de Dominio (`/domain`)

-   **Entidades:**
    -   `BackupSettings`: Modelo para la configuración de backups (frecuencia, habilitado, directorio, hora, retención).
    -   `BackupMetadata`: Modelo para los metadatos de un backup (fecha creación, versión app, tamaño).
-   **Repositorios (Interfaces):**
    -   `BackupRepository`: Define las operaciones abstractas (crear, restaurar, listar, eliminar, compartir, importar, configurar, obtener metadatos).

### 3.2. Capa de Datos (`/data`)

-   **Repositorios (Implementaciones):**
    -   `BackupRepositoryImpl`: Implementa `BackupRepository`. Interactúa con el sistema de archivos para copiar/gestionar el archivo de la base de datos SQLite y con `SharedPreferences` para guardar la configuración.
-   **Fuentes de Datos:**
    -   Acceso directo al archivo de la base de datos (`AppDatabase`).
    -   `SharedPreferences` para la configuración.

### 3.3. Capa Core (`/core`)

-   **Servicios:**
    -   `BackupService`: Orquesta las operaciones de backup utilizando `BackupRepository`.
    -   **(Fase 2) AutomaticBackupService`: Gestiona la programación y ejecución de backups automáticos.

### 3.4. Capa de Presentación (`/presentation`)

-   **Providers:**
    -   `BackupProvider`: Gestiona el estado de la UI relacionado con los backups (lista de backups, estado de carga, errores, configuración).
-   **Pantallas:**
    -   `BackupScreen`: Pantalla principal para listar, crear, importar y gestionar backups.
    -   `BackupSettingsScreen`: Pantalla para configurar las copias automáticas (Fase 2).
-   **Componentes (Moléculas/Átomos):**
    -   `BackupListItem`: Elemento de lista para mostrar un backup individual.
    -   Botones para acciones (Crear, Importar, Compartir, Eliminar, Restaurar).

## 4. Flujo Técnico Detallado

### 4.1. Crear Backup Manual

1.  **Usuario:** Inicia la acción "Crear Backup" desde la UI.
2.  **Provider (`BackupProvider`):** Llama a `backupService.createBackup()`.
3.  **Servicio (`BackupService`):** Llama a `backupRepository.createBackup()`.
4.  **Repositorio (`BackupRepositoryImpl`):**
    a. Obtiene la ruta del archivo de la base de datos actual (`AppDatabase.getDatabasePath()`).
    b. Obtiene/Crea el directorio de backups (`path_provider`).
    c. Genera un nombre de archivo único con timestamp (ej: `moneyt_backup_YYYYMMDD_HHMMSS.db`).
    d. Copia el archivo de la base de datos al directorio de backups.
    e. Devuelve el `File` del backup creado.
5.  **Provider:** Actualiza la lista de backups y notifica a la UI.

### 4.2. Restaurar Backup

1.  **Usuario:** Selecciona un backup y elige "Restaurar".
2.  **UI:** Muestra un diálogo de confirmación crítico.
3.  **Provider:** Si se confirma, llama a `backupService.restoreBackup(selectedFile)`.
4.  **Servicio:** Llama a `backupRepository.restoreBackup(selectedFile)`.
5.  **Repositorio:**
    a. Obtiene la ruta del archivo de la base de datos actual.
    b. **Importante:** Cierra la conexión activa a la base de datos (`AppDatabase.close()`).
    c. (Opcional pero recomendado) Crea una copia temporal de la BD actual por seguridad.
    d. Copia el archivo de backup seleccionado sobre el archivo de la base de datos actual.
    e. **Importante:** Indica a la aplicación que debe reinicializar la conexión a la base de datos (puede requerir reiniciar la app o recargar los datos).
    f. (Opcional) Elimina la copia temporal si la restauración fue exitosa.
6.  **Provider:** Notifica a la UI sobre el éxito/fallo y la necesidad de recargar datos/reiniciar.

### 4.3. Listar Backups

1.  **Provider:** Llama a `backupService.listBackups()` al inicializarse o al refrescar.
2.  **Servicio:** Llama a `backupRepository.listBackups()`.
3.  **Repositorio:**
    a. Obtiene el directorio de backups.
    b. Lista los archivos `.db` en el directorio.
    c. Ordena los archivos por fecha de modificación (más recientes primero).
    d. Devuelve la lista de `File`.
4.  **Provider:** Almacena la lista y notifica a la UI.

### 4.4. Eliminar Backup

1.  **Usuario:** Selecciona un backup y elige "Eliminar".
2.  **UI:** Muestra diálogo de confirmación.
3.  **Provider:** Si se confirma, llama a `backupService.deleteBackup(selectedFile)`.
4.  **Servicio:** Llama a `backupRepository.deleteBackup(selectedFile)`.
5.  **Repositorio:** Elimina el archivo del sistema.
6.  **Provider:** Actualiza la lista de backups y notifica a la UI.

### 4.5. Compartir Backup

1.  **Usuario:** Selecciona un backup y elige "Compartir".
2.  **Provider:** Llama a `backupService.shareBackup(selectedFile)`.
3.  **Servicio:** Llama a `backupRepository.shareBackup(selectedFile)`.
4.  **Repositorio:** Utiliza el paquete `share_plus` para compartir el archivo.

### 4.6. Importar Backup

1.  **Usuario:** Inicia la acción "Importar Backup".
2.  **Provider:** Llama a `backupService.importBackupFromFile()`.
3.  **Servicio:** Llama a `backupRepository.importBackup()`.
4.  **Repositorio:**
    a. Utiliza `file_picker` para permitir al usuario seleccionar un archivo `.db`.
    b. Si se selecciona un archivo, lo copia al directorio de backups de la aplicación.
    c. Devuelve el `File` del backup importado (o `null` si se cancela).
5.  **Provider:** Actualiza la lista de backups si la importación fue exitosa.

## 5. Roadmap de Implementación (Incremental)

### Fase 1: Operaciones Manuales Básicas (MVP)

1.  **Definir Dominio:** Crear `BackupRepository` (interfaz) y entidades (`BackupMetadata`, `BackupSettings`).
2.  **Implementar Repositorio:** Crear `BackupRepositoryImpl` con lógica para:
    -   `createBackup`
    -   `listBackups`
    -   `restoreBackup` (incluyendo cierre/reapertura de BD)
    -   `deleteBackup`
    -   `getBackupMetadata`
3.  **Crear Servicio:** Implementar `BackupService` que use el repositorio.
4.  **Inyección de Dependencias:** Registrar `BackupRepository`, `BackupService` en GetIt.
5.  **Crear Provider:** Implementar `BackupProvider` para gestionar el estado.
6.  **Desarrollar UI (`BackupScreen`):**
    -   Mostrar lista de backups (`BackupListItem`).
    -   Botón para "Crear Backup".
    -   Acciones por item: Restaurar (con confirmación), Eliminar (con confirmación), Ver Metadatos.
7.  **Integrar:** Conectar la UI con el `BackupProvider`.
8.  **Pruebas:** Probar creación, listado, restauración y eliminación.

### Fase 2: Importar/Exportar y Mejoras UI

1.  **Implementar Repositorio:** Añadir lógica para `shareBackup` y `importBackup` en `BackupRepositoryImpl`.
2.  **Actualizar Servicio y Provider:** Exponer las nuevas funcionalidades.
3.  **Actualizar UI:**
    -   Añadir botón "Importar Backup".
    -   Añadir acción "Compartir" a cada item de backup.
    -   Mostrar indicadores de carga y mensajes de error/éxito.
    -   Mejorar visualización de metadatos.
4.  **Pruebas:** Probar importación y exportación.

### Fase 3: Backups Automáticos (Opcional)

1.  **Implementar Repositorio:** Añadir lógica para `configureAutomaticBackup` y `getBackupSettings` (usando `SharedPreferences`).
2.  **Actualizar Servicio y Provider:** Exponer configuración.
3.  **Crear `AutomaticBackupService`:** Lógica para programar y ejecutar backups (podría usar `workmanager` o similar). Implementar política de retención (eliminar backups antiguos).
4.  **Desarrollar UI (`BackupSettingsScreen`):** Permitir habilitar/deshabilitar, configurar frecuencia, hora y retención.
5.  **Notificaciones:** Integrar notificaciones para informar sobre backups automáticos (éxito/fallo).
6.  **Pruebas:** Probar programación, ejecución y retención automática.

### Fase 4: Cifrado y Almacenamiento Externo (Opcional Avanzado)

1.  **Cifrado:** Investigar e implementar cifrado/descifrado de archivos de backup (ej: usando `encrypt`).
2.  **Almacenamiento Externo:** Integrar con APIs de servicios en la nube (Google Drive, Dropbox) para guardar/restaurar backups.

## 6. Consideraciones Clave

-   **Permisos:** Solicitar permisos de almacenamiento necesarios (especialmente en Android).
-   **Gestión de Conexión a BD:** Es **crítico** cerrar la conexión a la base de datos *antes* de sobrescribirla durante la restauración y manejar la reapertura/reinicio de la app correctamente.
-   **Compatibilidad de Versiones:** Incluir la versión de la app en los metadatos. Considerar mecanismos de migración si el esquema de la BD cambia significativamente entre versiones.
-   **Manejo de Errores:** Implementar manejo robusto de errores para operaciones de archivo y base de datos.
-   **Feedback al Usuario:** Proveer feedback claro durante operaciones largas (crear, restaurar) y mostrar mensajes de éxito o error.
-   **Espacio de Almacenamiento:** Informar al usuario sobre el tamaño de los backups y considerar la compresión si los archivos son muy grandes.

## 7. Dependencias Potenciales

-   `path_provider`: Para obtener directorios del sistema.
-   `share_plus`: Para compartir archivos.
-   `file_picker`: Para seleccionar archivos al importar.
-   `drift` / `sqflite`: Para interactuar con la base de datos (obtener ruta, cerrar conexión).
-   `provider`: Para la gestión del estado.
-   `get_it` / `injectable`: Para inyección de dependencias.
-   `intl`: Para formateo de fechas.
-   `shared_preferences`: Para guardar la configuración.
-   `package_info_plus`: Para obtener la versión de la app.
-   **(Fase 3) workmanager` / `cron`: Para programación de tareas en segundo plano.
-   **(Fase 3) flutter_local_notifications`: Para notificaciones.
-   **(Fase 4) encrypt`: Para cifrado.
-   **(Fase 4) googleapis` / `googleapis_auth`: Para integración con Google Drive.

Este esquema proporciona una guía completa para la implementación del sistema de copias de seguridad. Puedes ajustarlo según las prioridades y complejidad que desees alcanzar en cada fase.
