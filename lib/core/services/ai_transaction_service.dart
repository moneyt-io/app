import 'dart:convert';
import 'package:flutter/widgets.dart'; // Añadido para characters
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/wallet.dart';

class AITransactionResult {
  final String type; // 'E' or 'I'
  final double amount;
  final List<AICategorySuggestionItem> categorySuggestions;
  final int? walletId;
  final String description;
  final DateTime? date;

  AITransactionResult({
    required this.type,
    required this.amount,
    required this.categorySuggestions,
    this.walletId,
    required this.description,
    this.date,
  });

  factory AITransactionResult.fromJson(Map<String, dynamic> json) {
    List<AICategorySuggestionItem> suggestions = [];
    if (json['categorySuggestions'] != null) {
      for (var item in json['categorySuggestions']) {
        suggestions.add(AICategorySuggestionItem.fromJson(item as Map<String, dynamic>));
      }
    }
    // Fallback if the AI uses the old format
    if (suggestions.isEmpty) {
      suggestions.add(AICategorySuggestionItem(
        categoryId: json['categoryId'] as int?,
        newCategoryName: json['suggestedCategoryName']?.toString(),
      ));
    }

    return AITransactionResult(
      type: json['type']?.toString() ?? 'E',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      categorySuggestions: suggestions,
      walletId: json['walletId'] as int?,
      description: json['description']?.toString() ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }
}

class AICategorySuggestionItem {
  final int? categoryId;
  final String? newCategoryName;
  final String? newCategoryIcon;

  AICategorySuggestionItem({
    this.categoryId,
    this.newCategoryName,
    this.newCategoryIcon,
  });

  factory AICategorySuggestionItem.fromJson(Map<String, dynamic> json) {
    return AICategorySuggestionItem(
      categoryId: json['categoryId'] as int?,
      newCategoryName: json['newCategoryName']?.toString(),
      newCategoryIcon: json['newCategoryIcon']?.toString(),
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
      "categorySuggestions": [
         // DEBES sugerir EXACTAMENTE 3 opciones de categorías. El formato de cada opción es:
         // {"categoryId": ID_de_la_lista_o_null, "newCategoryName": "NombreNuevo_o_null", "newCategoryIcon": "Emoji_O_null"}
         // Si encuentras una categoría existente que coincide, envía su categoryId y lo demas nulo.
         // Si no coincide o quieres proponer una nueva alternativa, envía categoryId nulo, un newCategoryName (1 o 2 palabras) y en newCategoryIcon un UNICO EMOJI que lo represente (ej: 🍔).
         // La primera opción debe ser la más acertada.
      ],
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
        
        // Validar y limpiar las sugerencias
        List<AICategorySuggestionItem> validSuggestions = [];
        for (var sugg in result.categorySuggestions) {
          int? validId = sugg.categoryId;
          if (validId != null && !categories.any((c) => c.id == validId)) {
            validId = null;
          }
          
          String? validName = sugg.newCategoryName;
          if (validId == null && (validName == null || validName.trim().isEmpty || validName.toLowerCase() == 'null')) {
            validName = result.description.isNotEmpty ? result.description.split(' ').first : 'Varios';
            if (validName.isNotEmpty) {
              validName = validName[0].toUpperCase() + validName.substring(1).toLowerCase();
            }
          }
          
          String? validIcon = sugg.newCategoryIcon;
          if (validId == null && validName != null && (validIcon == null || validIcon.trim().isEmpty)) {
            validIcon = '✨'; // Fallback
          }
          
          validSuggestions.add(AICategorySuggestionItem(
            categoryId: validId,
            newCategoryName: validId == null ? validName : null,
            newCategoryIcon: validId == null ? validIcon : null,
          ));
        }

        return AITransactionResult(
          type: result.type,
          amount: result.amount,
          categorySuggestions: validSuggestions,
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

  Future<List<String>> suggestEmojiForCategory(String categoryName) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return ['🏷️', '💰', '✨'];
    }

    final model = GenerativeModel(
      model: 'gemini-flash-lite-latest',
      apiKey: apiKey,
    );

    final prompt = 'Sugiere 3 emojis que mejor representen la siguiente categoría financiera o tipo de gasto/ingreso: "$categoryName". Devuelve ÚNICAMENTE los 3 emojis seguidos, sin espacios ni texto adicional (ejemplo: 🍔🍕🌮).';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final String? responseText = response.text;
      
      if (responseText != null && responseText.trim().isNotEmpty) {
        final chars = responseText.trim().characters.toList();
        if (chars.isNotEmpty) {
          final emojis = chars.take(3).toList();
          while (emojis.length < 3) {
            emojis.add('🏷️');
          }
          return emojis;
        }
      }
      return ['🏷️', '💰', '✨'];
    } catch (e) {
      print('=== AI Emoji Error ===');
      print(e);
      return ['🏷️', '💰', '✨'];
    }
  }

  Future<List<AICategorySuggestionItem>> suggestCategoriesForTransaction(
    String description,
    List<Category> categories,
  ) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) return [];

    final model = GenerativeModel(
      model: 'gemini-flash-lite-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );

    final categoriesJson = categories.map((c) => {'id': c.id, 'name': c.name, 'type': c.documentTypeId}).toList();

    final prompt = '''
    Analiza la siguiente descripción de una transacción financiera: "$description".
    
    Tu tarea es sugerir exactamente 3 categorías posibles para esta transacción.
    DEBES devolver ÚNICAMENTE un arreglo JSON con exactamente 3 objetos.
    IMPORTANTE SOBRE EL IDIOMA: Si la descripción está en español, sugiere nombres en español. Si está en inglés, en inglés, etc. Adáptate al idioma de la descripción, ignorando el idioma del sistema.
    
    Reglas para cada objeto:
    - Si la descripción coincide bien con una de las categorías existentes, devuelve su "categoryId" y "newCategoryName"/"newCategoryIcon" en null.
    - Si ninguna categoría existente es un buen match, devuelve "categoryId" en null y propón un "newCategoryName" corto (1 o 2 palabras) en el MISMO IDIOMA de la descripción, junto con un "newCategoryIcon" que sea UN EMOJI que represente esa categoría.
    - El primer objeto del arreglo debe ser tu mejor sugerencia absoluta (la que se autoseleccionará).
    - El formato exacto de cada objeto debe ser: {"categoryId": numero_o_null, "newCategoryName": "String_o_null", "newCategoryIcon": "Emoji_o_null"}
    
    Categorías existentes disponibles:
    ${jsonEncode(categoriesJson)}
    ''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final String? responseText = response.text;
      
      if (responseText != null) {
        String cleanText = responseText.trim();
        if (cleanText.startsWith('```json')) cleanText = cleanText.substring(7);
        else if (cleanText.startsWith('```')) cleanText = cleanText.substring(3);
        if (cleanText.endsWith('```')) cleanText = cleanText.substring(0, cleanText.length - 3);
        
        final List<dynamic> data = jsonDecode(cleanText.trim());
        
        final List<AICategorySuggestionItem> results = [];
        for (var item in data) {
          final suggestion = AICategorySuggestionItem.fromJson(item as Map<String, dynamic>);
          
          int? validId = suggestion.categoryId;
          if (validId != null) {
            if (!categories.any((c) => c.id == validId)) {
              validId = null;
            }
          }
          
          String? validName = suggestion.newCategoryName;
          if (validId == null && (validName == null || validName.trim().isEmpty || validName.toLowerCase() == 'null')) {
            validName = 'Varios';
          }
          
          if (validId == null && validName != null && validName.isNotEmpty) {
             validName = validName[0].toUpperCase() + validName.substring(1).toLowerCase();
          }
          
          String? validIcon = suggestion.newCategoryIcon;
          if (validId == null && validName != null && (validIcon == null || validIcon.trim().isEmpty)) {
            validIcon = '✨';
          }
          
          results.add(AICategorySuggestionItem(
            categoryId: validId,
            newCategoryName: validId == null ? validName : null,
            newCategoryIcon: validId == null ? validIcon : null,
          ));
        }
        
        return results;
      }
    } catch (e) {
      print('=== AI Category Suggestion Error ===');
      print(e);
    }
    return [];
  }
}
