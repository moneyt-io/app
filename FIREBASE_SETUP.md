# Configuración de Firebase en MoneyT

Este documento describe los pasos necesarios para configurar Firebase en la aplicación MoneyT.

## Prerrequisitos

1. Tener una cuenta de Google
2. Tener instalado el Firebase CLI
3. Tener Flutter y Dart instalados

## Pasos de Configuración

### 1. Crear un Proyecto en Firebase

1. Ve a la [Consola de Firebase](https://console.firebase.google.com/)
2. Haz clic en "Crear un proyecto"
3. Nombra tu proyecto (ej: "moneyt-app")
4. Sigue los pasos del asistente

### 2. Configurar Firebase en la Aplicación Android

1. En la consola de Firebase, haz clic en el ícono de Android
2. Registra la app con el package name: `com.moneyt.app`
3. Descarga el archivo `google-services.json`
4. Coloca el archivo en `android/app/google-services.json`

### 3. Configurar Firebase en la Aplicación iOS

1. En la consola de Firebase, haz clic en el ícono de iOS
2. Registra la app con el Bundle ID: `com.moneyt.app`
3. Descarga el archivo `GoogleService-Info.plist`
4. Coloca el archivo en `ios/Runner/GoogleService-Info.plist`

### 4. Configurar Firestore

1. En la consola de Firebase, ve a "Firestore Database"
2. Crea una base de datos en modo de prueba
3. Selecciona la ubicación más cercana a tus usuarios
4. Sube las reglas de seguridad desde el archivo `firebase.rules`
5. Sube los índices desde el archivo `firestore.indexes.json`

### 5. Configurar Autenticación

1. En la consola de Firebase, ve a "Authentication"
2. Habilita los siguientes métodos de autenticación:
   - Email/Password
   - Google Sign-In

### 6. Configurar Google Sign-In

#### Android
1. En la consola de Firebase, ve a Project Settings
2. En la sección "Your apps", selecciona la app de Android
3. Agrega la huella digital SHA-1 de tu clave de depuración:
   ```bash
   cd android
   ./gradlew signingReport
   ```
4. Copia la huella SHA-1 y agrégala en la configuración de la app

#### iOS
1. En Xcode, actualiza el archivo `Info.plist` con los esquemas de URL necesarios
2. Configura el soporte de Sign-in con Google siguiendo la [documentación oficial](https://pub.dev/packages/google_sign_in)

## Verificación

Para verificar que todo está configurado correctamente:

1. Ejecuta la aplicación
2. Intenta iniciar sesión con Google
3. Verifica que los datos se sincronicen con Firestore

## Solución de Problemas

### Error de SHA-1 en Android
Si tienes problemas con el inicio de sesión de Google en Android:
1. Verifica que la huella SHA-1 esté correctamente configurada
2. Asegúrate de estar usando la misma clave de firma que registraste

### Error de Configuración en iOS
Si tienes problemas con el inicio de sesión en iOS:
1. Verifica que el Bundle ID coincida con el registrado en Firebase
2. Asegúrate de que los esquemas de URL estén correctamente configurados

## Recursos Adicionales

- [Documentación de FlutterFire](https://firebase.flutter.dev/docs/overview/)
- [Guía de Autenticación de Firebase](https://firebase.google.com/docs/auth)
- [Guía de Cloud Firestore](https://firebase.google.com/docs/firestore)
