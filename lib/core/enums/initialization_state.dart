/// Estados posibles durante la inicialización de la aplicación
/// 
/// Define los diferentes momentos del flujo de inicialización
/// y ayuda a determinar qué acciones tomar en cada caso.
enum InitializationState {
  /// Primera vez que se abre la aplicación
  /// Requiere: Onboarding + Seeds + (Opcional) Auth
  firstLaunch,
  
  /// La aplicación se ha abierto antes pero falta completar el onboarding
  /// Requiere: Onboarding + validar Seeds
  needsOnboarding,
  
  /// Onboarding completado pero faltan los datos iniciales (seeds)
  /// Requiere: Seeds + continuar flujo normal
  needsSeeds,
  
  /// Todo completado pero el usuario necesita autenticarse
  /// Requiere: Auth (solo si es requerido)
  needsAuth,
  
  /// Inicialización completada, ir directo a la aplicación
  /// Acción: Navegar a Dashboard
  completed,
  
  /// Error durante la inicialización
  /// Requiere: Manejo de errores + opciones de recuperación
  error,
  
  /// Estado desconocido - requiere verificación completa
  /// Requiere: Re-evaluar todos los estados
  unknown;
  
  /// Determina si este estado requiere mostrar onboarding
  bool get requiresOnboarding {
    return this == InitializationState.firstLaunch || 
           this == InitializationState.needsOnboarding;
  }
  
  /// Determina si este estado requiere ejecutar seeds
  bool get requiresSeeds {
    return this == InitializationState.firstLaunch || 
           this == InitializationState.needsSeeds;
  }
  
  /// Determina si este estado requiere autenticación
  bool get requiresAuth {
    return this == InitializationState.needsAuth;
  }
  
  /// Determina si este estado permite continuar a la app principal
  bool get canProceedToApp {
    return this == InitializationState.completed;
  }
  
  /// Determina si este estado indica un error
  bool get isError {
    return this == InitializationState.error;
  }
  
  /// Determina si necesita verificación adicional
  bool get needsVerification {
    return this == InitializationState.unknown;
  }
  
  /// Descripción legible del estado (útil para debugging)
  String get description {
    switch (this) {
      case InitializationState.firstLaunch:
        return 'Primera apertura de la aplicación';
      case InitializationState.needsOnboarding:
        return 'Necesita completar onboarding';
      case InitializationState.needsSeeds:
        return 'Necesita datos iniciales';
      case InitializationState.needsAuth:
        return 'Necesita autenticación';
      case InitializationState.completed:
        return 'Inicialización completada';
      case InitializationState.error:
        return 'Error en inicialización';
      case InitializationState.unknown:
        return 'Estado desconocido';
    }
  }
  
  /// Ruta sugerida para este estado
  String get suggestedRoute {
    switch (this) {
      case InitializationState.firstLaunch:
      case InitializationState.needsOnboarding:
        return '/onboarding';
      case InitializationState.needsAuth:
        return '/auth/welcome';
      case InitializationState.completed:
        return '/dashboard';
      case InitializationState.needsSeeds:
        return '/splash'; // Mostrar splash mientras se ejecutan seeds
      case InitializationState.error:
        return '/error/initialization';
      case InitializationState.unknown:
        return '/splash'; // Re-evaluar en splash
    }
  }
}
