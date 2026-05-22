class IconToEmojiMapper {
  static String getEmoji(String iconName) {
    // Si la cadena está vacía o nula, devolver emoji por defecto
    if (iconName.trim().isEmpty) return '🏷️';

    // Si la cadena no contiene letras de la A a la Z, asumimos que es un código numérico (codePoint)
    // o un emoji real, así que lo devolvemos tal cual (o lo convertimos si hiciera falta).
    // Nota: en V2 se guardan emojis reales como '🍔'.
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(iconName);
    if (!hasLetters) {
      // Si el texto es numérico puro (un codePoint de icono material legacy)
      if (int.tryParse(iconName) != null) {
        // En tu versión legacy, los codePoints no estaban mapeados aquí, pero en caso de haberlos
        return '🏷️';
      }
      // Es un emoji directo
      return iconName;
    }

    const map = {
      'fastfood': '🍔',
      'restaurant': '🍽️',
      'local_dining': '🍱',
      'directions_car': '🚗',
      'commute': '🚌',
      'local_taxi': '🚕',
      'shopping_cart': '🛍️',
      'shopping_bag': '👜',
      'local_grocery_store': '🛒',
      'movie': '🎬',
      'theaters': '🎭',
      'health_and_safety': '💊',
      'local_hospital': '🏥',
      'medical_services': '🩺',
      'home': '🏠',
      'house': '🏡',
      'flight': '✈️',
      'airplanemode_active': '🛫',
      'school': '🎓',
      'menu_book': '📚',
      'fitness_center': '🏋️‍♂️',
      'sports_gymnastics': '🤸',
      'pets': '🐾',
      'child_care': '👶',
      'work': '💼',
      'business_center': '🏢',
      'receipt': '🧾',
      'payment': '💳',
      'attach_money': '💵',
      'money': '💸',
      'account_balance': '🏦',
      'savings': '🐷',
      'electrical_services': '⚡',
      'water_drop': '💧',
      'wifi': '📶',
      'phone_iphone': '📱',
      'computer': '💻',
      'gamepad': '🎮',
      'stroller': '🍼',
      'celebration': '🎉',
      'cake': '🎂',
      'smoking_rooms': '🚬',
      'liquor': '🍷',
      'local_bar': '🍺',
      'local_cafe': '☕',
      'emoji_food_beverage': '🍵',
      'park': '🌳',
      'forest': '🌲',
      'pool': '🏊‍♂️',
      'beach_access': '🏖️',
    };

    return map[iconName] ?? '🏷️';
  }
}
