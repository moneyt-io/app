import 'package:flutter/material.dart';

class IconToEmojiMapper {
  /// Mapeo directo de los IconData de CategoryIconPicker a Emojis
  static final Map<IconData, String> _iconDataMap = {
    // Finanzas & Cuentas
    Icons.account_balance_wallet: '👛',
    Icons.wallet: '👛',
    Icons.credit_card: '💳',
    Icons.payments: '💵',
    Icons.attach_money: '💵',
    Icons.savings: '🐷',
    Icons.account_balance: '🏦',
    Icons.currency_exchange: '💱',
    Icons.calculate: '🔢',
    Icons.trending_up: '📈',

    // Trabajo y Negocios
    Icons.work: '💼',
    Icons.business: '🏢',
    Icons.laptop_mac: '💻',

    // Hogar y Vida Diaria
    Icons.home: '🏠',
    Icons.restaurant: '🍽️',
    Icons.local_gas_station: '⛽',
    Icons.shopping_cart: '🛒',
    Icons.medical_services: '🩺',
    Icons.school: '🎓',
    Icons.directions_car: '🚗',
    Icons.flight: '✈️',
    Icons.movie: '🎬',
    Icons.fitness_center: '🏋️‍♂️',
    Icons.pets: '🐾',
    Icons.child_care: '👶',
    Icons.phone: '📱',
    Icons.bolt: '⚡',
    Icons.water_drop: '💧',
    Icons.wifi: '📶',
  };

  /// Mapeo de codePoints legacy guardados en versiones anteriores
  static const Map<int, String> _legacyCodePointMap = {
    // Wallets & Finanzas legacy
    58376: '👛', // Icons.account_balance_wallet legacy
    58392: '👛',
    57409: '👛', // Icons.account_balance_wallet current
    60460: '👛', // Icons.wallet legacy
    983723: '👛',
    985044: '👛', // Icons.wallet current
    57895: '💳', // Icons.credit_card legacy
    57759: '💳', // Icons.credit_card current
    59714: '💵', // Icons.payments legacy
    58498: '💵', // Icons.payments current
    58639: '🐷', // Icons.savings legacy
    58707: '🐷', // Icons.savings current
    57775: '🏦', // Icons.account_balance legacy
    57408: '🏦', // Icons.account_balance current
    57534: '💵', // Icons.attach_money legacy
    57522: '💵', // Icons.attach_money current
    59730: '💱', // Icons.currency_exchange legacy
    984284: '💱', // Icons.currency_exchange current
    57588: '🔢', // Icons.calculate legacy
    57633: '🔢', // Icons.calculate current
    58894: '📈', // Icons.trending_up legacy
    59007: '📈', // Icons.trending_up current

    // Trabajo y Negocios
    58987: '💼', // Icons.work legacy
    59122: '💼', // Icons.work current
    57579: '🏢', // Icons.business legacy
    57627: '🏢', // Icons.business current
    58209: '💻', // Icons.laptop_mac legacy
    58217: '💻', // Icons.laptop_mac current

    // Hogar y Vida Diaria
    58138: '🏠', // Icons.home legacy
    58136: '🏠', // Icons.home current
    58614: '🍽️', // Icons.restaurant legacy
    58674: '🍽️', // Icons.restaurant current
    58249: '⛽', // Icons.local_gas_station legacy
    58260: '⛽', // Icons.local_gas_station current
    58711: '🛒', // Icons.shopping_cart legacy
    58780: '🛒', // Icons.shopping_cart current
    58315: '🩺', // Icons.medical_services legacy
    58328: '🩺', // Icons.medical_services current
    58641: '🎓', // Icons.school legacy
    58713: '🎓', // Icons.school current
    57813: '🚗', // Icons.directions_car legacy
    57815: '🚗', // Icons.directions_car current
    57887: '✈️', // Icons.flight legacy
    58007: '✈️', // Icons.flight current
    58380: '🎬', // Icons.movie legacy
    58381: '🎬', // Icons.movie current
    57884: '🏋️‍♂️', // Icons.fitness_center legacy
    57997: '🏋️‍♂️', // Icons.fitness_center current
    58514: '🐾', // Icons.pets legacy
    58529: '🐾', // Icons.pets current
    57640: '👶', // Icons.child_care legacy
    57696: '👶', // Icons.child_care current
    58525: '📱', // Icons.phone legacy
    58530: '📱', // Icons.phone current
    57560: '⚡', // Icons.bolt legacy
    57582: '⚡', // Icons.bolt current
    59005: '💧', // Icons.water_drop legacy
    984482: '💧', // Icons.water_drop current
    59111: '📶', // Icons.wifi current
  };

  /// Mapeo de nombres de Material Icons a Emojis
  static const Map<String, String> _nameMap = {
    // Wallets & Dinero
    'account_balance_wallet': '👛',
    'wallet': '👛',
    'credit_card': '💳',
    'payment': '💳',
    'payments': '💵',
    'attach_money': '💵',
    'money': '💸',
    'cash': '💵',
    'account_balance': '🏦',
    'bank': '🏦',
    'savings': '🐷',
    'currency_exchange': '💱',
    'calculate': '🔢',
    'trending_up': '📈',

    // Comida & Restaurantes
    'fastfood': '🍔',
    'restaurant': '🍽️',
    'local_dining': '🍱',
    'local_cafe': '☕',
    'emoji_food_beverage': '🍵',
    'local_bar': '🍺',
    'liquor': '🍷',
    'cake': '🎂',
    'celebration': '🎉',

    // Transporte
    'directions_car': '🚗',
    'commute': '🚌',
    'local_taxi': '🚕',
    'flight': '✈️',
    'airplanemode_active': '🛫',
    'local_gas_station': '⛽',

    // Compras
    'shopping_cart': '🛒',
    'local_grocery_store': '🛒',
    'shopping_bag': '👜',
    'receipt': '🧾',

    // Entretenimiento y Deporte
    'movie': '🎬',
    'theaters': '🎭',
    'gamepad': '🎮',
    'fitness_center': '🏋️‍♂️',
    'sports_gymnastics': '🤸',
    'pool': '🏊‍♂️',
    'beach_access': '🏖️',
    'park': '🌳',
    'forest': '🌲',

    // Salud
    'health_and_safety': '💊',
    'local_hospital': '🏥',
    'medical_services': '🩺',

    // Hogar y Servicios
    'home': '🏠',
    'house': '🏡',
    'electrical_services': '⚡',
    'water_drop': '💧',
    'wifi': '📶',
    'phone_iphone': '📱',
    'computer': '💻',
    'laptop_mac': '💻',

    // Educación & Trabajo
    'school': '🎓',
    'menu_book': '📚',
    'work': '💼',
    'business_center': '🏢',
    'business': '🏢',

    // Familia & Mascotas
    'pets': '🐾',
    'child_care': '👶',
    'stroller': '🍼',
    'smoking_rooms': '🚬',
  };

  static String getEmoji(String iconName) {
    if (iconName.trim().isEmpty) return '👛';

    // 1. Si es numérico (codePoint decimal o hex)
    final codePoint = int.tryParse(iconName) ?? int.tryParse(iconName, radix: 16);
    if (codePoint != null) {
      // Primero verificar en la lista constante de IconData
      for (final entry in _iconDataMap.entries) {
        if (entry.key.codePoint == codePoint) {
          return entry.value;
        }
      }
      // Segundo verificar en el mapa de codePoints legacy
      if (_legacyCodePointMap.containsKey(codePoint)) {
        return _legacyCodePointMap[codePoint]!;
      }
      return '👛';
    }

    // 2. Si contiene letras alfabéticas, buscar en el mapa de nombres
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(iconName);
    if (hasLetters) {
      final normalized = iconName.toLowerCase().trim();
      return _nameMap[normalized] ?? '🏷️';
    }

    // 3. Es un emoji directo
    return iconName;
  }
}
