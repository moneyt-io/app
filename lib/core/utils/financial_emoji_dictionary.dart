class FinancialEmojiDictionary {
  static final Map<String, String> _dictionary = {
    // === ALIMENTACIÓN / FOOD ===
    'comida': '🍽️', 'food': '🍽️', 'restaurante': '🍽️', 'restaurant': '🍽️', 
    'cena': '🍽️', 'dinner': '🍽️', 'almuerzo': '🍱', 'lunch': '🍱',
    'desayuno': '🥞', 'breakfast': '🥞', 'delivery': '🛵', 'pedidos': '🛵',
    'hamburguesa': '🍔', 'burger': '🍔', 'fast food': '🍔', 'comida rapida': '🍔',
    'pizza': '🍕', 'sushi': '🍣', 'tacos': '🌮', 'pollo': '🐔', 'chicken': '🐔',
    'carne': '🥩', 'meat': '🥩', 'pescado': '🐟', 'fish': '🐟',
    'supermercado': '🛒', 'supermarket': '🛒', 'despensa': '🛒', 'mercado': '🛒',
    'compra': '🛒', 'groceries': '🛒', 'grocery': '🛒',
    'cafe': '☕', 'coffee': '☕', 'cafeteria': '☕', 'bakery': '🥐', 'panaderia': '🥐',
    'helado': '🍦', 'ice cream': '🍦', 'postre': '🍰', 'dessert': '🍰',
    'cerveza': '🍺', 'beer': '🍺', 'bar': '🍻', 'pub': '🍻',
    'vino': '🍷', 'wine': '🍷', 'licor': '🥃', 'alcohol': '🥃', 'drinks': '🍸', 'bebidas': '🍸',

    // === TRANSPORTE / TRANSPORT ===
    'transporte': '🚌', 'transport': '🚌', 'bus': '🚌', 'colectivo': '🚌', 'transporte publico': '🚌',
    'auto': '🚗', 'carro': '🚗', 'coche': '🚗', 'car': '🚗', 'vehiculo': '🚗', 'vehicle': '🚗',
    'gasolina': '⛽', 'gas': '⛽', 'combustible': '⛽', 'fuel': '⛽', 'nafta': '⛽',
    'taxi': '🚕', 'uber': '🚕', 'cab': '🚕', 'did': '🚕',
    'tren': '🚆', 'train': '🚆', 'metro': '🚇', 'subway': '🚇',
    'bici': '🚲', 'bicicleta': '🚲', 'bike': '🚲', 'bicycle': '🚲',
    'estacionamiento': '🅿️', 'parking': '🅿️', 'peaje': '🅿️', 'toll': '🅿️',
    'mecanico': '🔧', 'mechanic': '🔧', 'taller': '🔧', 'garage': '🔧', 'mantenimiento': '🛠️',

    // === VIVIENDA / HOUSING ===
    'casa': '🏠', 'hogar': '🏠', 'house': '🏠', 'home': '🏠', 'vivienda': '🏠',
    'departamento': '🏢', 'apartment': '🏢', 'piso': '🏢',
    'alquiler': '🔑', 'renta': '🔑', 'rent': '🔑', 'hipoteca': '🏦', 'mortgage': '🏦',
    'muebles': '🛋️', 'furniture': '🛋️', 'decoracion': '🖼️', 'decoration': '🖼️',
    'reparaciones': '🔨', 'repairs': '🔨', 'ferreteria': '🧰', 'hardware': '🧰',

    // === SERVICIOS / UTILITIES ===
    'luz': '💡', 'electricidad': '⚡', 'energia': '⚡', 'electricity': '⚡', 'power': '⚡',
    'agua': '💧', 'water': '💧', 'acueducto': '💧',
    'gas natural': '🔥', 'calefaccion': '🔥', 'heating': '🔥',
    'internet': '🌐', 'wifi': '📶', 'cable': '📺', 'tv': '📺',
    'telefono': '📱', 'celular': '📱', 'movil': '📱', 'phone': '📱', 'mobile': '📱',
    'basura': '🗑️', 'trash': '🗑️', 'limpieza': '🧹', 'cleaning': '🧹',

    // === COMPRAS Y OCIO / SHOPPING & LEISURE ===
    'ropa': '👕', 'vestimenta': '👕', 'clothes': '👕', 'clothing': '👕', 'apparel': '👕',
    'zapatos': '👟', 'zapatillas': '👟', 'shoes': '👟', 'sneakers': '👟',
    'accesorios': '💍', 'accessories': '💍', 'joyas': '💎', 'jewelry': '💎',
    'cine': '🎬', 'pelicula': '🎬', 'movie': '🎬', 'cinema': '🎬',
    'juego': '🎮', 'videojuego': '🎮', 'gaming': '🎮', 'games': '🎮',
    'entretenimiento': '🎪', 'entertainment': '🎪', 'ocio': '🎭', 'fun': '🎭',
    'suscripcion': '🔁', 'subscription': '🔁', 'netflix': '🍿', 'spotify': '🎵',
    'musica': '🎧', 'music': '🎧', 'concierto': '🎫', 'concert': '🎫',

    // === SALUD Y CUIDADO / HEALTH & CARE ===
    'salud': '⚕️', 'health': '⚕️', 'medico': '🩺', 'doctor': '🩺',
    'farmacia': '💊', 'pharmacy': '💊', 'pastilla': '💊', 'medicina': '💊', 'medicine': '💊',
    'hospital': '🏥', 'clinica': '🏥', 'clinic': '🏥',
    'dentista': '🦷', 'dentist': '🦷', 'terapia': '🛋️', 'therapy': '🛋️',
    'gimnasio': '🏋️', 'gym': '🏋️', 'ejercicio': '🏃', 'workout': '🏃', 'fitness': '🧘',
    'peluqueria': '✂️', 'haircut': '✂️', 'salon': '✂️', 'barberia': '💈',
    'belleza': '💅', 'beauty': '💅', 'cosmeticos': '💄', 'cosmetics': '💄', 'skincare': '🧴',

    // === VIAJES / TRAVEL ===
    'viaje': '✈️', 'vuelo': '✈️', 'avion': '✈️', 'travel': '✈️', 'flight': '✈️', 'airplane': '✈️',
    'turismo': '🗺️', 'tourism': '🗺️', 'vacaciones': '🏖️', 'vacation': '🏖️',
    'hotel': '🏨', 'hospedaje': '🏨', 'hostal': '🏨', 'airbnb': '🧳',
    'pasaporte': '🛂', 'passport': '🛂', 'equipaje': '🧳', 'luggage': '🧳',

    // === EDUCACIÓN / EDUCATION ===
    'educacion': '🎓', 'education': '🎓', 'escuela': '🏫', 'school': '🏫', 'colegio': '🏫',
    'universidad': '🏛️', 'university': '🏛️', 'college': '🏛️',
    'estudio': '📚', 'study': '📚', 'libro': '📖', 'book': '📖', 'curso': '📝', 'course': '📝',
    'utiles': '✏️', 'stationery': '✏️', 'clases': '👨‍🏫', 'classes': '👩‍🏫',

    // === FAMILIA Y MASCOTAS / FAMILY & PETS ===
    'hijo': '🧒', 'hija': '👧', 'bebe': '👶', 'nino': '👦', 'niño': '👦', 'kid': '👦', 'baby': '👶',
    'familia': '👨‍👩‍👧', 'family': '👨‍👩‍👧', 'guarderia': '🧸', 'daycare': '🧸',
    'mascota': '🐾', 'pet': '🐾', 'perro': '🐶', 'dog': '🐶', 'gato': '🐱', 'cat': '🐱',
    'veterinario': '🏥', 'vet': '🏥', 'comida perro': '🦴', 'comida gato': '🐟',

    // === TRABAJO E INGRESOS / WORK & INCOME ===
    'trabajo': '💼', 'empleo': '💼', 'work': '💼', 'job': '💼', 'oficina': '🏢', 'office': '🏢',
    'sueldo': '💰', 'salario': '💰', 'salary': '💰', 'wage': '💰', 'ingreso': '💵', 'income': '💵',
    'honorarios': '🧾', 'freelance': '💻', 'negocio': '🤝', 'business': '🤝',
    'ventas': '📈', 'sales': '📈', 'bono': '🎁', 'bonus': '🎁',

    // === FINANZAS Y BANCOS / FINANCE & BANKING ===
    'efectivo': '💵', 'cash': '💵', 'billetes': '💵', 'plata': '💵', 'dinero': '💵', 'money': '💵',
    'billetera': '👛', 'wallet': '👛', 'cartera': '👛', 'monedero': '👛', 'bolsillo': '👛',
    'banco': '🏦', 'bank': '🏦', 'cuenta': '🏦', 'corriente': '🏦', 'ahorro': '🐷', 'savings': '🐷', 'alcancia': '🐷',
    'inversion': '💹', 'investment': '💹', 'acciones': '📈', 'stocks': '📈', 'bolsa': '📈',
    'cripto': '🪙', 'crypto': '🪙', 'bitcoin': '🪙', 'moneda': '🪙', 'monedas': '🪙', 'coins': '🪙',
    'tarjeta': '💳', 'card': '💳', 'credito': '💳', 'credit': '💳', 'debito': '💳', 'debit': '💳', 'visa': '💳', 'mastercard': '💳', 'amex': '💳',
    'nequi': '📱', 'daviplata': '📱', 'mercadopago': '📱', 'mp': '📱', 'paypal': '📱', 'zinli': '📱', 'uala': '📱',
    'prestamo': '💸', 'loan': '💸', 'deuda': '📉', 'debt': '📉',
    'impuestos': '🏛️', 'taxes': '🏛️', 'seguro': '🛡️', 'insurance': '🛡️',
    'pago': '✅', 'payment': '✅', 'transferencia': '🔄', 'transfer': '🔄',

    // === OTROS / OTHERS ===
    'regalo': '🎁', 'obsequio': '🎁', 'gift': '🎁', 'present': '🎁',
    'fiesta': '🎉', 'celebracion': '🎉', 'evento': '🎈', 'party': '🎉', 'event': '🎈',
    'donacion': '🤝', 'donation': '🤝', 'caridad': '❤️', 'charity': '❤️',
    'multa': '⚠️', 'fine': '⚠️', 'ticket': '🎟️'
  };

  /// Elimina tildes y caracteres especiales comunes para mejorar la búsqueda
  static String _normalize(String text) {
    String normalized = text.toLowerCase().trim();
    normalized = normalized.replaceAll(RegExp(r'[áäâà]'), 'a');
    normalized = normalized.replaceAll(RegExp(r'[éëêè]'), 'e');
    normalized = normalized.replaceAll(RegExp(r'[íïîì]'), 'i');
    normalized = normalized.replaceAll(RegExp(r'[óöôò]'), 'o');
    normalized = normalized.replaceAll(RegExp(r'[úüûù]'), 'u');
    return normalized;
  }

  /// Busca la palabra exacta. Si no está, busca si la palabra ingresada
  /// contiene alguna de las claves del diccionario.
  static String? getEmojiForKeyword(String keyword) {
    if (keyword.trim().isEmpty) return null;
    
    final normalizedKeyword = _normalize(keyword);
    
    // 1. Búsqueda exacta
    if (_dictionary.containsKey(normalizedKeyword)) {
      return _dictionary[normalizedKeyword];
    }

    // 2. Búsqueda parcial (si el usuario escribe "comida rapida" y tenemos "comida")
    // Se priorizan las coincidencias más largas para ser más precisos.
    String? bestMatch;
    int longestMatchLength = 0;

    for (final entry in _dictionary.entries) {
      if (normalizedKeyword.contains(entry.key)) {
        if (entry.key.length > longestMatchLength) {
          bestMatch = entry.value;
          longestMatchLength = entry.key.length;
        }
      }
    }

    return bestMatch;
  }
}
