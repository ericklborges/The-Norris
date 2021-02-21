// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Error {
    internal enum Dafault {
      /// Try again
      internal static let buttonTitle = L10n.tr("Facts", "error.dafault.buttonTitle")
      /// Norris brain could not process your request, try again later.
      internal static let message = L10n.tr("Facts", "error.dafault.message")
      /// Something wrong
      internal static let title = L10n.tr("Facts", "error.dafault.title")
    }
    internal enum EmptyResult {
      /// Try again
      internal static let buttonTitle = L10n.tr("Facts", "error.emptyResult.buttonTitle")
      /// Unfortunatly Norris did not create a word for that. Yet.
      internal static let message = L10n.tr("Facts", "error.emptyResult.message")
      /// Nothing found
      internal static let title = L10n.tr("Facts", "error.emptyResult.title")
    }
    internal enum FirstTime {
      /// Tap to search
      internal static let buttonTitle = L10n.tr("Facts", "error.firstTime.buttonTitle")
      /// Start looking for the most interesting facts about Norris you've ever seen.
      internal static let message = L10n.tr("Facts", "error.firstTime.message")
      /// First time around?
      internal static let title = L10n.tr("Facts", "error.firstTime.title")
    }
    internal enum InvalidQuery {
      /// Try again
      internal static let buttonTitle = L10n.tr("Facts", "error.invalidQuery.buttonTitle")
      /// Norris will ignore any search with less than 3 characters. It is a waste of time for him.
      internal static let message = L10n.tr("Facts", "error.invalidQuery.message")
      /// Invalid search
      internal static let title = L10n.tr("Facts", "error.invalidQuery.title")
    }
    internal enum NoConnection {
      /// Try again
      internal static let buttonTitle = L10n.tr("Facts", "error.noConnection.buttonTitle")
      /// Norris can share information telepathically, but you don't. Go get some internet.
      internal static let message = L10n.tr("Facts", "error.noConnection.message")
      /// No connection
      internal static let title = L10n.tr("Facts", "error.noConnection.title")
    }
  }

  internal enum FactsList {
    /// Facts
    internal static let title = L10n.tr("Facts", "factsList.title")
    internal enum Fact {
      /// Uncategorized
      internal static let defaultCategory = L10n.tr("Facts", "factsList.fact.defaultCategory")
    }
  }

  internal enum FactsSearch {
    internal enum Searchbar {
      /// search for a fact
      internal static let placeholder = L10n.tr("Facts", "factsSearch.searchbar.placeholder")
    }
    internal enum Section {
      internal enum PastQueries {
        /// Past searches
        internal static let title = L10n.tr("Facts", "factsSearch.section.pastQueries.title")
      }
      internal enum Suggestions {
        /// Suggestions
        internal static let title = L10n.tr("Facts", "factsSearch.section.suggestions.title")
      }
    }
  }

  internal enum Loading {
    /// Norris brain is processing your request, it won't take long.
    internal static let message = L10n.tr("Facts", "loading.message")
    /// Thinking
    internal static let title = L10n.tr("Facts", "loading.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
