import 'dart:convert';
import 'package:flutter/widgets.dart'; // Añadido para characters
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/wallet.dart';

class AITransactionResult {
  final String type; // 'E' or 'I'
  final double amount;
  final int? categoryId;
  final String? suggestedCategoryName;
  final int? walletId;
  final String description;
  final DateTime? date;

  AITransactionResult({
    required this.type,
    required this.amount,
    this.categoryId,
    this.suggestedCategoryName,
    this.walletId,
    required this.description,
    this.date,
  });

  factory AITransactionResult.fromJson(Map<String, dynamic> json) {
    return AITransactionResult(
      type: json['type']?.toString() ?? 'E',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] as int?,
      suggestedCategoryName: json['suggestedCategoryName']?.toString(),
      walletId: json['walletId'] as int?,
      description: json['description']?.toString() ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }
}

class AITransactionService {
  Future<AITransactionResult?> parseTransaction(
    String text,
    List<Category> categories,
    List<Wallet> wallets,
  ) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('No GEMINI_API_KEY found in .env');
    }

    final model = GenerativeModel(
      model: 'gemini-flash-lite-latest', // Cambiado para mayor compatibilidad
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );

    final categoriesJson = categories.map((c) => {'id': c.id, 'name': c.name, 'type': c.documentTypeId}).toList();
    final walletsJson = wallets.map((w) => {'id': w.id, 'name': w.name}).toList();

    final currentDate = DateTime.now().toIso8601String().split('T')[0];

    final prompt = '''
    Actúa como un asistente financiero inteligente. Analiza este texto dictado por un usuario: "$text".
    
    Hoy es la fecha: $currentDate.

    Extrae la siguiente información y devuelve ÚNICAMENTE un objeto JSON válido con esta estructura exacta:
    {
      "type": "E" (si es un gasto/pago) o "I" (si es un ingreso/cobro),
      "amount": (número positivo flotante, ej: 50.0),
      "categoryId": (el ID de la categoría que coincida exactamente de las Opciones. Si no encuentras ninguna adecuada, DEBES enviar null),
      "suggestedCategoryName": (Si mandaste categoryId nulo, DEBES escribir aquí el nombre de una nueva categoría de 1 o 2 palabras, ej: "Suscripciones", "Uber". De lo contrario, null),
      "walletId": (el ID de la billetera/cuenta que mejor coincida, o null),
      "description": (Un resumen de 1 a 3 palabras de lo que fue, ej: "Café Starbucks"),
      "date": (Calcula la fecha a la que se refiere el usuario en formato "YYYY-MM-DD", si dice ayer u otro día, calcúlalo en base a hoy. Si no menciona ninguna fecha explícita, devuelve null)
    }

    Opciones de Categorías disponibles:
    ${jsonEncode(categoriesJson)}

    Opciones de Billeteras/Cuentas disponibles:
    ${jsonEncode(walletsJson)}
    ''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final String? responseText = response.text;
      
      if (responseText != null) {
        String cleanText = responseText.trim();
        
        // Limpiar posible formato Markdown de la respuesta (ej. ```json ... ```)
        if (cleanText.startsWith('```json')) {
          cleanText = cleanText.substring(7);
        } else if (cleanText.startsWith('```')) {
          cleanText = cleanText.substring(3);
        }
        if (cleanText.endsWith('```')) {
          cleanText = cleanText.substring(0, cleanText.length - 3);
        }
        
        final Map<String, dynamic> data = jsonDecode(cleanText.trim());
        print('=== AI JSON RECIBIDO ===');
        print(data);
        
        final result = AITransactionResult.fromJson(data);
        
        // Validar que el categoryId realmente exista en nuestra lista
        int? validCategoryId = result.categoryId;
        if (validCategoryId != null) {
          final exists = categories.any((c) => c.id == validCategoryId);
          if (!exists) {
            validCategoryId = null; // Forzar a nulo si la IA inventó un ID
          }
        }
        
        // Si el ID es nulo, ASEGURARNOS de que haya un suggestedCategoryName
        String? finalSuggestion = result.suggestedCategoryName;
        if (validCategoryId == null && (finalSuggestion == null || finalSuggestion.trim().isEmpty || finalSuggestion.toLowerCase() == 'null')) {
          // Fallback: Si la IA falló en dar un nombre, intentamos extraer de la descripción o usar un genérico
          finalSuggestion = result.description.isNotEmpty ? result.description.split(' ').first : 'Varios';
          // Capitalizar
          if (finalSuggestion.isNotEmpty) {
            finalSuggestion = finalSuggestion[0].toUpperCase() + finalSuggestion.substring(1).toLowerCase();
          }
        }

        return AITransactionResult(
          type: result.type,
          amount: result.amount,
          categoryId: validCategoryId,
          suggestedCategoryName: finalSuggestion,
          walletId: result.walletId,
          description: result.description,
          date: result.date,
        );
      }
      return null;
    } catch (e, st) {
      print('=== AI Service Error ===');
      print(e);
      print(st);
      throw Exception('Fallo al analizar respuesta JSON: $e');
    }
  }

  Future<String> suggestEmojiForCategory(String categoryName) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return '🏷️';
    }

    final model = GenerativeModel(
      model: 'gemini-flash-lite-latest',
      apiKey: apiKey,
    );

    final prompt = 'Sugiere el emoji que mejor represente la siguiente categoría financiera o tipo de gasto/ingreso: "$categoryName". Devuelve ÚNICAMENTE un emoji, sin texto adicional.';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final String? responseText = response.text;
      
      if (responseText != null && responseText.trim().isNotEmpty) {
        // En caso de que la IA responda algo como "🍔 - Hamburguesa", agarramos solo el primer character/emoji
        final chars = responseText.trim().characters;
        if (chars.isNotEmpty) {
          return chars.first;
        }
      }
      return '🏷️';
    } catch (e) {
      print('=== AI Emoji Error ===');
      print(e);
      return '🏷️';
    }
  }
}
