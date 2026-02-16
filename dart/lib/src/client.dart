import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

/// Validation rule for a parameter.
class ValidationRule {
  final String type;
  final bool required;
  final num? min;
  final num? max;
  final int? minLength;
  final int? maxLength;
  final String? format;
  final List<String>? enumValues;

  const ValidationRule({
    required this.type,
    required this.required,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.format,
    this.enumValues,
  });
}

/// Exception thrown when parameter validation fails.
class InvoicegeneratorValidationException implements Exception {
  final List<String> errors;

  InvoicegeneratorValidationException(this.errors);

  @override
  String toString() => 'InvoicegeneratorValidationException: ${errors.join("; ")}';
}

/// Format validation patterns.
final _formatPatterns = {
  'email': RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$'),
  'url': RegExp(r'^https?://.+'),
  'ip': RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$'),
  'date': RegExp(r'^\d{4}-\d{2}-\d{2}$'),
  'hexColor': RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$'),
};

/// Invoice Generator API client.
///
/// For more information, visit: https://apiverve.com/marketplace/invoicegenerator?utm_source=dart&utm_medium=readme
///
/// Parameters:
/// * [invoiceNumber] (required) - The invoice number
/// * [date] - The invoice date (YYYY-MM-DD format) [format: date]
/// * [fromName] (required) - The name of the person or company issuing the invoice
/// * [fromStreet] (required) - The street address of the person or company issuing the invoice
/// * [fromCity] (required) - The city of the person or company issuing the invoice
/// * [fromState] (required) - The state of the person or company issuing the invoice [maxLength: 2]
/// * [fromZip] (required) - The zip code of the person or company issuing the invoice [minLength: 5, maxLength: 10]
/// * [toName] (required) - The name of the person or company being invoiced
/// * [toStreet] (required) - The street address of the person or company being invoiced
/// * [toCity] (required) - The city of the person or company being invoiced
/// * [toState] (required) - The state of the person or company being invoiced [maxLength: 2]
/// * [toZip] (required) - The zip code of the person or company being invoiced [minLength: 5, maxLength: 10]
/// * [job] - The job or project associated with the invoice
/// * [paymentTerms] - The payment terms for the invoice
/// * [dueDate] - The due date for the invoice (YYYY-MM-DD format) [format: date]
/// * [discount] - The discount to be applied to the invoice [min: 0]
/// * [salesTax] - The sales tax rate for the invoice (as percentage) [min: 0, max: 100]
/// * [currency] - The currency for the invoice
/// * [items] (required) - The items being invoiced (qty, description, unit_price)
class InvoicegeneratorClient {
  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  /// Validation rules for parameters.
  static final Map<String, ValidationRule> _validationRules = <String, ValidationRule>{
    'invoiceNumber': ValidationRule(type: 'string', required: true),
    'date': ValidationRule(type: 'string', required: false, format: 'date'),
    'from_name': ValidationRule(type: 'string', required: true),
    'from_street': ValidationRule(type: 'string', required: true),
    'from_city': ValidationRule(type: 'string', required: true),
    'from_state': ValidationRule(type: 'string', required: true, maxLength: 2),
    'from_zip': ValidationRule(type: 'string', required: true, minLength: 5, maxLength: 10),
    'to_name': ValidationRule(type: 'string', required: true),
    'to_street': ValidationRule(type: 'string', required: true),
    'to_city': ValidationRule(type: 'string', required: true),
    'to_state': ValidationRule(type: 'string', required: true, maxLength: 2),
    'to_zip': ValidationRule(type: 'string', required: true, minLength: 5, maxLength: 10),
    'job': ValidationRule(type: 'string', required: false),
    'paymentTerms': ValidationRule(type: 'string', required: false),
    'dueDate': ValidationRule(type: 'string', required: false, format: 'date'),
    'discount': ValidationRule(type: 'number', required: false, min: 0),
    'salesTax': ValidationRule(type: 'number', required: false, min: 0, max: 100),
    'currency': ValidationRule(type: 'string', required: false),
    'items': ValidationRule(type: 'array', required: true),
  };

  InvoicegeneratorClient(this.apiKey, {
    this.baseUrl = 'https://api.apiverve.com/v1/invoicegenerator',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Validates parameters against defined rules.
  /// Throws [InvoicegeneratorValidationException] if validation fails.
  void _validateParams(Map<String, dynamic> params) {
    final errors = <String>[];

    for (final entry in _validationRules.entries) {
      final paramName = entry.key;
      final rule = entry.value;
      final value = params[paramName];

      // Check required
      if (rule.required && (value == null || (value is String && value.isEmpty))) {
        errors.add('Required parameter [$paramName] is missing');
        continue;
      }

      if (value == null) continue;

      // Type-specific validation
      if (rule.type == 'integer' || rule.type == 'number') {
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) {
          errors.add('Parameter [$paramName] must be a valid ${rule.type}');
          continue;
        }
        if (rule.min != null && numValue < rule.min!) {
          errors.add('Parameter [$paramName] must be at least ${rule.min}');
        }
        if (rule.max != null && numValue > rule.max!) {
          errors.add('Parameter [$paramName] must be at most ${rule.max}');
        }
      } else if (rule.type == 'string' && value is String) {
        if (rule.minLength != null && value.length < rule.minLength!) {
          errors.add('Parameter [$paramName] must be at least ${rule.minLength} characters');
        }
        if (rule.maxLength != null && value.length > rule.maxLength!) {
          errors.add('Parameter [$paramName] must be at most ${rule.maxLength} characters');
        }
        if (rule.format != null && _formatPatterns.containsKey(rule.format)) {
          if (!_formatPatterns[rule.format]!.hasMatch(value)) {
            errors.add('Parameter [$paramName] must be a valid ${rule.format}');
          }
        }
      }

      // Enum validation
      if (rule.enumValues != null && rule.enumValues!.isNotEmpty) {
        if (!rule.enumValues!.contains(value.toString())) {
          errors.add('Parameter [$paramName] must be one of: ${rule.enumValues!.join(", ")}');
        }
      }
    }

    if (errors.isNotEmpty) {
      throw InvoicegeneratorValidationException(errors);
    }
  }

  /// Execute a request to the Invoice Generator API.
  ///
  /// Parameters are validated before sending the request.
  Future<InvoicegeneratorResponse> execute(Map<String, dynamic> params) async {
    // Validate parameters
    _validateParams(params);
    if (apiKey.isEmpty) {
      throw InvoicegeneratorException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final response = await _httpClient.post(
        Uri.parse(baseUrl),
        headers: {
          'x-api-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return InvoicegeneratorResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw InvoicegeneratorException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw InvoicegeneratorException('Resource not found');
      } else {
        throw InvoicegeneratorException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is InvoicegeneratorException) rethrow;
      throw InvoicegeneratorException('Request failed: $e');
    }
  }


  /// Close the HTTP client.
  void close() {
    _httpClient.close();
  }
}

/// Exception thrown by the Invoice Generator API client.
class InvoicegeneratorException implements Exception {
  final String message;

  InvoicegeneratorException(this.message);

  @override
  String toString() => 'InvoicegeneratorException: $message';
}
