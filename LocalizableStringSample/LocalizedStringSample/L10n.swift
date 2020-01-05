// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// 端末言語:%@
  internal static func deviceSetting(_ p1: String) -> LocalizableKey {
    return L10n.tr("Localizable", "device_setting", p1)
  }
  /// 言語設定
  internal static let langSetting = L10n.tr("Localizable", "lang_setting")
  /// 画面再読み込み
  internal static let reloadScreen = L10n.tr("Localizable", "reloadScreen")

  internal enum Lang {
    /// 英語
    internal static let en = L10n.tr("Localizable", "lang.en")
    /// 日本語
    internal static let ja = L10n.tr("Localizable", "lang.ja")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details
