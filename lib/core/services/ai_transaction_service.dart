import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/wallet.dart';

class AITransactionResult {
  final String type; // 'E' or 'I'
  final double amount;
  final int? categoryId;
  final int? walletId;
  final String description;

  AITransactionResult({
    required this.type,
    required this.amount,
    this.categoryId,
    this.walletId,
    required this.description,
  });

  factory AITransactionResult.fromJson(Map<String, dynamic> json) {
    return AITransactionResult(
      type: json['type']?.toString() ?? 'E',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] as int?,
      walletId: json['walletId'] as int?,
      description: json['description']?.toString() ?? '',
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

    final prompt = '''
    Actúa como un asistente financiero inteligente. Analiza este texto dictado por un usuario: "$text".

    Extrae la siguiente información y devuelve ÚNICAMENTE un objeto JSON válido con esta estructura exacta:
    {
      "type": "E" (si es un gasto/pago) o "I" (si es un ingreso/cobro),
      "amount": (número positivo flotante, ej: 50.0),
      "categoryId": (el ID de la categoría que mejor coincida, o null),
      "walletId": (el ID de la billetera/cuenta que mejor coincida, o null),
      "description": (Un resumen de 1 a 3 palabras de lo que fue, ej: "Café Starbucks")
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
        return AITransactionResult.fromJson(data);
      }
      return null;
    } catch (e, st) {
      print('=== AI Service Error ===');
      print(e);
      print(st);
      throw Exception('Fallo al analizar respuesta JSON: $e');
    }
  }
}
