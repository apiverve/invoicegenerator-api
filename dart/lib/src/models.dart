/// Response models for the Invoice Generator API.

/// API Response wrapper.
class InvoicegeneratorResponse {
  final String status;
  final dynamic error;
  final InvoicegeneratorData? data;

  /// Set only when the current plan locks one or more fields; null otherwise.
  final PremiumInfo? premium;

  InvoicegeneratorResponse({
    required this.status,
    this.error,
    this.data,
    this.premium,
  });

  factory InvoicegeneratorResponse.fromJson(Map<String, dynamic> json) => InvoicegeneratorResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? InvoicegeneratorData.fromJson(json['data']) : null,
    premium: json['premium'] != null ? PremiumInfo.fromJson(json['premium']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
    if (premium != null) 'premium': premium!.toJson(),
  };
}

/// Describes fields the current plan does not unlock. Locked fields arrive as null
/// in [data], and [lockedFields] names them (nested ones use dot paths).
class PremiumInfo {
  final String? message;
  final String? upgradeUrl;
  final List<String>? lockedFields;

  PremiumInfo({this.message, this.upgradeUrl, this.lockedFields});

  factory PremiumInfo.fromJson(Map<String, dynamic> json) => PremiumInfo(
    message: json['message'] as String?,
    upgradeUrl: json['upgrade_url'] as String?,
    lockedFields: (json['locked_fields'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (message != null) 'message': message,
    if (upgradeUrl != null) 'upgrade_url': upgradeUrl,
    if (lockedFields != null) 'locked_fields': lockedFields,
  };
}

/// Response data for the Invoice Generator API.

class InvoicegeneratorData {
  String? pdfName;
  num? expires;
  String? downloadURL;

  InvoicegeneratorData({
    this.pdfName,
    this.expires,
    this.downloadURL,
  });

  factory InvoicegeneratorData.fromJson(Map<String, dynamic> json) => InvoicegeneratorData(
      pdfName: json['pdfName'],
      expires: json['expires'],
      downloadURL: json['downloadURL'],
    );
}

class InvoicegeneratorRequest {
  String invoiceNumber;
  String? date;
  String? dueDate;
  String fromName;
  String fromStreet;
  String fromCity;
  String fromState;
  String fromZip;
  String toName;
  String toStreet;
  String toCity;
  String toState;
  String toZip;
  String? job;
  String? paymentTerms;
  num? discount;
  num? salesTax;
  String? currency;
  List<Map<String, dynamic>> items;

  InvoicegeneratorRequest({
    required this.invoiceNumber,
    this.date,
    this.dueDate,
    required this.fromName,
    required this.fromStreet,
    required this.fromCity,
    required this.fromState,
    required this.fromZip,
    required this.toName,
    required this.toStreet,
    required this.toCity,
    required this.toState,
    required this.toZip,
    this.job,
    this.paymentTerms,
    this.discount,
    this.salesTax,
    this.currency,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
      'invoiceNumber': invoiceNumber,
      if (date != null) 'date': date,
      if (dueDate != null) 'dueDate': dueDate,
      'from_name': fromName,
      'from_street': fromStreet,
      'from_city': fromCity,
      'from_state': fromState,
      'from_zip': fromZip,
      'to_name': toName,
      'to_street': toStreet,
      'to_city': toCity,
      'to_state': toState,
      'to_zip': toZip,
      if (job != null) 'job': job,
      if (paymentTerms != null) 'paymentTerms': paymentTerms,
      if (discount != null) 'discount': discount,
      if (salesTax != null) 'salesTax': salesTax,
      if (currency != null) 'currency': currency,
      'items': items,
    };
}
