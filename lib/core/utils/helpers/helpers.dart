import 'package:flutter/material.dart'; // Needed if using BuildContext approach
import 'package:intl/intl.dart';

class Helpers {
  /// Formats a numeric amount as a currency string based on locale.
  ///
  /// Args:
  ///   amount: The numeric value to format. Can be null.
  ///   context: The BuildContext used to determine the locale for formatting.
  ///   locale: Optional explicit locale string (e.g., 'en_US', 'en_GB', 'de_DE').
  ///           If provided, overrides locale from context.
  ///   symbol: Optional explicit currency symbol (e.g., '$', '£', '€').
  ///           If provided, often overrides the default symbol for the locale.
  ///           Use with caution, as it might conflict with locale standards.
  ///   decimalDigits: Number of decimal digits to show (defaults to 2).
  ///
  /// Returns:
  ///   A formatted currency string (e.g., "$1,234.56") or a default string
  ///   (like 'N/A') if the amount is null.
  static String formatCurrency(
    num? amount, // Use num? to accept int? or double?
    BuildContext context, {
    String? locale,
    String? symbol,
    int decimalDigits = 2, // Common default
  }) {
    if (amount == null) {
      // Decide what to return for null input. Empty string, 'N/A', 'Free', etc.
      return 'N/A';
    }

    // Determine the locale: explicit parameter > context locale > default
    String effectiveLocale = locale ?? Localizations.localeOf(context).toString();

    // Use default 'en_US' if context lookup fails or results in an unsupported format
    // You might want more robust locale validation depending on your needs
    try {
       // Check if locale is valid before using it, otherwise NumberFormat might throw
       // This is a basic check; real validation might be more complex
       Locale(effectiveLocale.split('_')[0], effectiveLocale.split('_').length > 1 ? effectiveLocale.split('_')[1] : null);
    } catch (e) {
       print("Warning: Invalid locale '$effectiveLocale' derived. Falling back to 'en_US'.");
       effectiveLocale = 'en_US'; // Fallback locale
    }


    // Create the NumberFormat instance
    // Providing both locale and symbol can sometimes have unintuitive results.
    // Usually, providing just the locale is preferred as it handles symbol and formatting.
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: effectiveLocale,
      symbol: symbol, // Use provided symbol if available, otherwise locale default
      decimalDigits: decimalDigits,
    );

    try {
       return currencyFormatter.format(amount);
    } catch (e) {
      print("Error formatting currency for locale '$effectiveLocale' and symbol '$symbol': $e");
      // Fallback formatting if locale/symbol causes issues
      return "${symbol ?? '\$'}${amount.toStringAsFixed(decimalDigits)}";
    }
  }

  // --- Alternative if you DON'T want to pass BuildContext ---
  // --- Requires explicitly passing locale and symbol if defaults aren't suitable ---
  static String formatCurrencySimple(
      num? amount, {
      String locale = 'en_US', // Default locale
      String? symbol,          // Default symbol comes from locale
      int decimalDigits = 2,
  }) {
      if (amount == null) {
          return 'N/A';
      }

      final NumberFormat currencyFormatter = NumberFormat.currency(
          locale: locale,
          symbol: symbol,
          decimalDigits: decimalDigits,
      );
      try{
          return currencyFormatter.format(amount);
      } catch (e) {
          print("Error formatting currency (simple) for locale '$locale': $e");
          // Basic fallback
          return "${symbol ?? NumberFormat.simpleCurrency(locale: locale).currencySymbol}${amount.toStringAsFixed(decimalDigits)}";
      }

  }

}