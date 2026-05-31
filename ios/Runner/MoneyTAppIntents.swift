import AppIntents
import UIKit
import Flutter
import UserNotifications
import SwiftUI

@available(iOS 16.0, *)
struct CategoryEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Categoría"
    static var defaultQuery = CategoryEntityQuery()
    
    var id: String
    var name: String
    var isNew: Bool
    var categoryId: Int?
    var icon: String?
    
    var displayRepresentation: DisplayRepresentation {
        if isNew {
            let newText = String(localized: "manual_intent_new_label")
            return DisplayRepresentation(stringLiteral: "\(icon ?? "🏷️") \(name) \(newText) ✨")
        } else {
            return DisplayRepresentation(stringLiteral: "\(icon ?? "🏷️") \(name)")
        }
    }
}

@available(iOS 16.0, *)
struct CategoryEntityQuery: EntityQuery {
    func entities(for identifiers: [CategoryEntity.ID]) async throws -> [CategoryEntity] { return [] }
    func suggestedEntities() async throws -> [CategoryEntity] { return [] }
}

@available(iOS 16.0, *)
struct WalletEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Cuenta"
    static var defaultQuery = WalletEntityQuery()
    
    var id: String
    var name: String
    var currencyId: String
    var currencySymbol: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(stringLiteral: name)
    }
}

@available(iOS 16.0, *)
struct WalletEntityQuery: EntityQuery {
    func entities(for identifiers: [WalletEntity.ID]) async throws -> [WalletEntity] { return [] }
    func suggestedEntities() async throws -> [WalletEntity] { return [] }
}

@available(iOS 16.0, *)
enum TransactionTypeEnum: String, AppEnum {
    case income = "I"
    case expense = "E"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Tipo de Movimiento"
    
    static var caseDisplayRepresentations: [TransactionTypeEnum: DisplayRepresentation] {
        [
            .income: "Ingreso",
            .expense: "Gasto"
        ]
    }
}

@available(iOS 16.0, *)
struct IntentError: Error, CustomLocalizedStringResourceConvertible {
    var message: String
    var localizedStringResource: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: message)
    }
}

@available(iOS 16.0, *)
struct TransactionSnippetView: View {
    var amount: Double
    var description: String
    var categoryName: String
    var icon: String
    var currencySymbol: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                Text(icon)
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(description.isEmpty ? categoryName : description)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(categoryName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(currencySymbol)\(String(format: "%.2f", amount))")
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.white)
                .foregroundColor(.black)
                .clipShape(Capsule())
        }
        .padding()
        .preferredColorScheme(.dark)
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
struct AITransactionIntent: AppIntent {
    static var title: LocalizedStringResource = "Registro con IA"
    static var description = IntentDescription("Registra una transacción en MoneyT en segundo plano mediante IA.")

    @Parameter(
        title: "Texto", 
        description: "Lo que quieres registrar",
        requestValueDialog: IntentDialog("¿Qué gasto deseas registrar?")
    )
    var text: String
    
    @Parameter(title: "Categoría Seleccionada")
    var category: CategoryEntity?

    @MainActor
    func perform() async throws -> some IntentResult {
        let cleanText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanText.isEmpty { throw CancellationError() }
        
        let service = FlutterBackgroundService.shared
        await service.start()
        defer { service.stop() }
        
        guard let parseResponse = try? await service.invoke(method: "parseTransaction", arguments: cleanText),
              let success = parseResponse["success"] as? Bool, success == true else {
            throw IntentError(message: "No se pudo entender el gasto")
        }
        
        guard let transaction = parseResponse["transaction"] as? [String: Any],
              let suggestedCategories = parseResponse["suggestedCategories"] as? [[String: Any]] else {
            throw IntentError(message: "Error interno de formato de datos")
        }
        
        var entities: [CategoryEntity] = []
        for cat in suggestedCategories {
            let catId = cat["id"] as? Int
            let name = cat["name"] as? String ?? "Varios"
            let icon = cat["icon"] as? String
            entities.append(CategoryEntity(id: catId != nil ? String(catId!) : UUID().uuidString, name: name, isNew: catId == nil, categoryId: catId, icon: icon))
        }
        
        let chosenCategory: CategoryEntity
        if entities.isEmpty {
            throw IntentError(message: "No hay categorías disponibles")
        } else if entities[0].isNew == false {
            chosenCategory = entities[0]
        } else {
            do {
                chosenCategory = try await $category.requestDisambiguation(among: entities, dialog: "¿En qué categoría?")
            } catch { throw CancellationError() }
        }
        
        let amount = transaction["amount"] as? Double ?? 0.0
        let description = transaction["description"] as? String ?? ""
        let currencySymbol = transaction["currencySymbol"] as? String ?? "$"
        let icon = chosenCategory.icon ?? "🏷️"
        let customView = TransactionSnippetView(amount: amount, description: description, categoryName: chosenCategory.name, icon: icon, currencySymbol: currencySymbol)
        
        try await requestConfirmation(result: .result(dialog: "", view: customView))
        
        var saveArgs = transaction
        saveArgs["categoryId"] = chosenCategory.categoryId
        if chosenCategory.isNew { 
            saveArgs["newCategoryName"] = chosenCategory.name
            saveArgs["newCategoryIcon"] = chosenCategory.icon
        }
        
        guard let saveResponse = try? await service.invoke(method: "saveTransaction", arguments: saveArgs),
              let saveSuccess = saveResponse["success"] as? Bool, saveSuccess == true else {
            throw IntentError(message: "Error al guardar el gasto")
        }
        
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        if settings.authorizationStatus == .notDetermined {
            _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge])
        }
        if settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional || settings.authorizationStatus == .notDetermined {
            let content = UNMutableNotificationContent()
            let formattedAmount = String(format: "%.2f", amount)
            content.title = description.isEmpty ? "\(currencySymbol)\(formattedAmount)" : "\(currencySymbol)\(formattedAmount) • \(description)"
            content.body = "\(icon) \(chosenCategory.name) • ✅"
            content.sound = .default
            try? await center.add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil))
        }
        
        return .result()
    }
}

@available(iOS 16.0, *)
struct ManualTransactionIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("manual_intent_title")
    static var description = IntentDescription(LocalizedStringResource("manual_intent_desc"))

    @Parameter(title: LocalizedStringResource("manual_intent_amount"))
    var amount: Double
    
    @Parameter(title: LocalizedStringResource("manual_intent_type"))
    var type: TransactionTypeEnum
    
    @Parameter(title: LocalizedStringResource("manual_intent_description"))
    var transactionDescription: String
    
    @Parameter(title: LocalizedStringResource("manual_intent_category"))
    var category: CategoryEntity?
    
    @Parameter(title: LocalizedStringResource("manual_intent_wallet"))
    var wallet: WalletEntity?

    @MainActor
    func perform() async throws -> some IntentResult {
        let service = FlutterBackgroundService.shared
        await service.start()
        defer { service.stop() }
        
        guard let dataResponse = try? await service.invoke(method: "getManualData", arguments: nil),
              let success = dataResponse["success"] as? Bool, success == true,
              let globalCurrencySymbol = dataResponse["globalCurrencySymbol"] as? String,
              let walletsList = dataResponse["wallets"] as? [[String: Any]],
              let categoriesList = dataResponse["categories"] as? [[String: Any]] else {
            throw IntentError(message: "Error cargando cuentas y categorías")
        }
        
        var catEntities: [CategoryEntity] = []
        for cat in categoriesList {
            if let id = cat["id"] as? Int, let name = cat["name"] as? String {
                let icon = cat["icon"] as? String
                catEntities.append(CategoryEntity(id: String(id), name: name, isNew: false, categoryId: id, icon: icon))
            }
        }
        
        var walletEntities: [WalletEntity] = []
        for w in walletsList {
            if let id = w["id"] as? Int, let name = w["name"] as? String, let curr = w["currencyId"] as? String {
                let sym = w["currencySymbol"] as? String ?? "$"
                walletEntities.append(WalletEntity(id: String(id), name: name, currencyId: curr, currencySymbol: sym))
            }
        }
        
        let chosenCategory: CategoryEntity
        do {
            chosenCategory = try await $category.requestDisambiguation(among: catEntities, dialog: IntentDialog(LocalizedStringResource("manual_intent_ask_category")))
        } catch { throw CancellationError() }
        
        let chosenWallet: WalletEntity
        if walletEntities.count == 1 {
            chosenWallet = walletEntities[0]
        } else {
            do {
                chosenWallet = try await $wallet.requestDisambiguation(among: walletEntities, dialog: IntentDialog(LocalizedStringResource("manual_intent_ask_wallet")))
            } catch { throw CancellationError() }
        }
        
        let icon = chosenCategory.icon ?? "🏷️"
        let customView = TransactionSnippetView(amount: amount, description: transactionDescription, categoryName: chosenCategory.name, icon: icon, currencySymbol: globalCurrencySymbol)
        
        try await requestConfirmation(result: .result(dialog: "", view: customView))
        
        let saveArgs: [String: Any] = [
            "type": type.rawValue,
            "amount": amount,
            "walletId": Int(chosenWallet.id) ?? 0,
            "currencyId": chosenWallet.currencyId,
            "description": transactionDescription,
            "categoryId": chosenCategory.categoryId ?? 0
        ]
        
        guard let saveResponse = try? await service.invoke(method: "saveTransaction", arguments: saveArgs),
              let saveSuccess = saveResponse["success"] as? Bool, saveSuccess == true else {
            throw IntentError(message: "Error al guardar el gasto")
        }
        
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        if settings.authorizationStatus == .notDetermined { _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge]) }
        if settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional || settings.authorizationStatus == .notDetermined {
            let content = UNMutableNotificationContent()
            let formattedAmount = String(format: "%.2f", amount)
            content.title = transactionDescription.isEmpty ? "\(globalCurrencySymbol)\(formattedAmount)" : "\(globalCurrencySymbol)\(formattedAmount) • \(transactionDescription)"
            content.body = "\(icon) \(chosenCategory.name) • ✅"
            content.sound = .default
            try? await center.add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil))
        }
        
        return .result()
    }
}

@available(iOS 16.0, *)
struct MoneyTAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AITransactionIntent(),
            phrases: [
                "Registro con IA en \(.applicationName)",
                "Procesar con IA en \(.applicationName)"
            ],
            shortTitle: "Registro con IA",
            systemImageName: "sparkles"
        )
        
        AppShortcut(
            intent: ManualTransactionIntent(),
            phrases: [
                "Registro manual en \(.applicationName)",
                "Agregar transacción en \(.applicationName)"
            ],
            shortTitle: "Registro manual",
            systemImageName: "plus.circle.fill"
        )
    }
}
