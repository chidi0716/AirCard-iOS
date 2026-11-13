import SwiftUI

/// In-app UI language setting.
///
/// Supports English, Simplified Chinese, Traditional Chinese, and the iPhone language.
///
/// The choice persists in UserDefaults and applies to every page immediately:
/// static `Text("…")` literals re-resolve through `.environment(\.locale, …)`,
/// while code-built strings go through `L10n.tr(_:_:)`.
final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    static let systemCode = "system"
    static let englishCode = "en"
    static let chineseCode = "zh-Hans"
    static let traditionalChineseCode = "zh-Hant"
    static let selectionKey = "aircard.language"

    /// NOTE: @Published + manual UserDefaults sync, NOT @AppStorage —
    /// @AppStorage inside an ObservableObject doesn't reliably emit
    /// objectWillChange, so the UI would only pick up the new language
    /// after a restart.
    @Published var selection: String = UserDefaults.standard.string(forKey: LanguageManager.selectionKey) ?? LanguageManager.systemCode {
        didSet {
            UserDefaults.standard.set(selection, forKey: Self.selectionKey)
        }
    }

    var effectiveCode: String {
        Self.resolveCode(selection: selection, preferredLanguage: Locale.preferredLanguages.first)
    }

    static func resolveCode(selection: String, preferredLanguage: String?) -> String {
        switch selection {
        case englishCode, chineseCode, traditionalChineseCode:
            return selection
        default:
            let language = Locale.Language(identifier: preferredLanguage ?? englishCode)
            guard language.languageCode?.identifier == "zh" else { return englishCode }
            return language.maximalIdentifier.split(separator: "-").contains("Hant")
                ? traditionalChineseCode : chineseCode
        }
    }

    /// Locale pushed into the SwiftUI environment so `Text("…")` literals switch language live.
    var effectiveLocale: Locale {
        Locale(identifier: effectiveCode)
    }
}

/// Localized string lookup that honors the in-app language override
/// (unlike `NSLocalizedString`, which always follows the system language).
///
/// Keys are the English source strings (with `%@` / `%lld` for interpolated values),
/// exactly as they appear in `Localizable.strings`.
enum L10n {
    /// Resolve `key` for the current in-app language and format it with `args`.
    /// Missing keys fall back to the key itself (English).
    static func tr(_ key: String, _ args: CVarArg...) -> String {
        let code = LanguageManager.shared.effectiveCode
        let bundle: Bundle = {
            if let path = Bundle.main.path(forResource: code, ofType: "lproj"),
               let b = Bundle(path: path) {
                return b
            }
            return .main
        }()
        let format = bundle.localizedString(forKey: key, value: key, table: nil)
        guard !args.isEmpty else { return format }
        return String(format: format, locale: LanguageManager.shared.effectiveLocale, arguments: args)
    }
}
