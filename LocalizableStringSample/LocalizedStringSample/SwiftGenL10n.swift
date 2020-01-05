// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// 日本語_ja
  internal static let 日本語 = L10n.tr("Localizable", "日本語")
  /// 画面再読み込み_ja
  internal static let 画面再読み込み = L10n.tr("Localizable", "画面再読み込み")
  /// 端末言語: %@_ja
  internal static func 端末言語(_ p1: String) -> String {
    return L10n.tr("Localizable", "端末言語:%@", p1)
  }
  /// 英語_ja
  internal static let 英語 = L10n.tr("Localizable", "英語")
  /// 言語設定_ja
  internal static let 言語設定 = L10n.tr("Localizable", "言語設定")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
