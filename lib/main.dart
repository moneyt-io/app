// lib/main.dart
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'core/di/injection_container.dart' as di;
import 'routes/app_routes.dart';
import 'data/local/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';

void main() async {
  // Asegurarse de que las dependencias de Flutter estén inicializadas
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar la base de datos
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(join(dbFolder.path, 'db.sqlite'));
  
  // Configurar Drift para usar SQLite
  final connection = NativeDatabase(file);
  
  // Inicializar la base de datos
  final database = AppDatabase();

  // Inicializar la inyección de dependencias
  await di.init(database);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Presupuesto',
      debugShowCheckedModeBanner: false, // Quitar el banner de debug
      theme: ThemeData(
        // Configuración del tema principal
        primarySwatch: Colors.blue,
        // Configuración del tema oscuro
        brightness: Brightness.light,
        // Configuración de los textos
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        // Configuración de los inputs
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        // Configuración de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        // Configuración de las cards
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      // Configuración del tema oscuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Aquí puedes personalizar más el tema oscuro si lo deseas
      ),
      // Usar el tema según el sistema
      themeMode: ThemeMode.system,
      // Configuración de las rutas
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}

// Función para conectar con la base de datos SQLite
QueryExecutor connect() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}