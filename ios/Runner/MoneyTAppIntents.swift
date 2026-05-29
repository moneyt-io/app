import Foundation
import AppIntents
import UIKit
import Flutter

@available(iOS 16.0, *)
struct CategoryEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Categoría"
    static var defaultQuery = CategoryEntityQuery()
    
    var id: String
    var name: String
    var isNew: Bool
    var categoryId: Int?
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(stringLiteral: isNew ? "✨ Crear: \(name)" : name)
    }
}

@available(iOS 16.0, *)
struct CategoryEntityQuery: EntityQuery {
    func entities(for identifiers: [CategoryEntity.ID]) async throws -> [CategoryEntity] {
        return []
    }
    func suggestedEntities() async throws -> [CategoryEntity] {
        return []
    }
}

@MainActor
class FlutterBackgroundService {
    static let shared = FlutterBackgroundService()
    var engine: FlutterEngine?
    var channel: FlutterMethodChannel?
    
    func start() async {
        if engine != nil { return }
        engine = FlutterEngine(name: "MoneyTBackgroundEngine")
        engine!.run(withEntrypoint: "backgroundMain")
        GeneratedPluginRegistrant.register(with: engine!)
        channel = FlutterMethodChannel(name: "com.moneyt.app/background_intent", binaryMessenger: engine!.binaryMessenger)
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    func stop() {
        engine?.destroyContext()
        engine = nil
        channel = nil
    }
    
    func invoke(method: String, arguments: Any?) async throws -> [String: Any] {
        guard let channel = channel else { throw CancellationError() }
        
        return try await withCheckedThrowingContinuation { continuation in
            var responded = false
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 15_000_000_000)
                if !responded {
                    responded = true
                    continuation.resume(throwing: NSError(domain: "Timeout", code: 1))
                }
            }
            
            channel.invokeMethod(method, arguments: arguments) { result in
                DispatchQueue.main.async {
                    if responded { return }
                    responded = true
                    
                    if let dict = result as? [String: Any] {
                        continuation.resume(returning: dict)
                    } else {
                        continuation.resume(throwing: NSError(domain: "InvalidResponse", code: 2))
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct ProcessTransactionIntent: AppIntent {
    static var title: LocalizedStringResource = "Procesar gasto con IA"
    static var description = IntentDescription("Registra una transacción en MoneyT en segundo plano.")

    static var openAppWhenRun: Bool = false

    @Parameter(
        title: "Texto", 
        description: "Lo que quieres registrar",
        requestValueDialog: IntentDialog("¿Qué gasto deseas registrar?")
    )
    var text: String
    
    @Parameter(title: "Categoría Seleccionada")
    var category: CategoryEntity?

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let cleanText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanText.isEmpty {
            throw CancellationError()
        }
        
        let service = FlutterBackgroundService.shared
        await service.start()
        
        defer {
            service.stop()
        }
        
        // 1. Analizar con IA
        guard let parseResponse = try? await service.invoke(method: "parseTransaction", arguments: cleanText),
              let success = parseResponse["success"] as? Bool, success == true else {
            return .result(dialog: "No se pudo entender el gasto")
        }
        
        guard let transaction = parseResponse["transaction"] as? [String: Any],
              let suggestedCategories = parseResponse["suggestedCategories"] as? [[String: Any]] else {
            return .result(dialog: "Error interno de formato de datos")
        }
        
        var entities: [CategoryEntity] = []
        for cat in suggestedCategories {
            let catId = cat["id"] as? Int
            let name = cat["name"] as? String ?? "Varios"
            let entity = CategoryEntity(
                id: catId != nil ? String(catId!) : UUID().uuidString,
                name: name,
                isNew: catId == nil,
                categoryId: catId
            )
            entities.append(entity)
        }
        
        // 2. Desambiguar si todas las categorías son nuevas o hay duda
        let chosenCategory: CategoryEntity
        if entities.isEmpty {
            return .result(dialog: "No hay categorías disponibles")
        } else if entities[0].isNew == false {
            // Si la IA confía en que es una categoría existente, la usamos de inmediato
            chosenCategory = entities[0]
        } else {
            // Si la primera opción es una categoría nueva, le pedimos al usuario que elija
            do {
                chosenCategory = try await $category.requestDisambiguation(among: entities, dialog: "¿En qué categoría?")
            } catch {
                throw CancellationError() // Usuario canceló el menú nativo
            }
        }
        
        // 2.5 Confirmación Nativa
        let amount = transaction["amount"] as? Double ?? 0.0
        let description = transaction["description"] as? String ?? ""
        let summary = """
        ¿Deseas registrar este movimiento?
        
        💰 Valor: $\(amount)
        📝 Detalle: \(description)
        🏷️ Categoría: \(chosenCategory.name)
        """
        
        try await requestConfirmation(result: .result(dialog: IntentDialog(stringLiteral: summary)))
        
        // 3. Guardar en Base de Datos
        var saveArgs = transaction
        saveArgs["categoryId"] = chosenCategory.categoryId
        if chosenCategory.isNew {
            saveArgs["newCategoryName"] = chosenCategory.name
        }
        
        guard let saveResponse = try? await service.invoke(method: "saveTransaction", arguments: saveArgs),
              let saveSuccess = saveResponse["success"] as? Bool, saveSuccess == true else {
            return .result(dialog: "Error al guardar el gasto")
        }
        
        return .result(dialog: IntentDialog(stringLiteral: "✅ Transacción guardada correctamente"))
    }
}

@available(iOS 16.0, *)
struct MoneyTAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ProcessTransactionIntent(),
            phrases: [
                "Registrar gasto en \(.applicationName)",
                "Procesar en \(.applicationName)",
                "Añadir a \(.applicationName)"
            ],
            shortTitle: "Procesar con IA",
            systemImageName: "sparkles"
        )
    }
}
