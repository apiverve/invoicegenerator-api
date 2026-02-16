/// Response models for the Invoice Generator API.

/// API Response wrapper.
class InvoicegeneratorResponse {
  final String status;
  final dynamic error;
  final InvoicegeneratorData? data;

  InvoicegeneratorResponse({
    required this.status,
    this.error,
    this.data,
  });

  factory InvoicegeneratorResponse.fromJson(Map<String, dynamic> json) => InvoicegeneratorResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? InvoicegeneratorData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
  };
}

/// Response data for the Invoice Generator API.

class InvoicegeneratorData {
  String? pdfName;
  int? expires;
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
  Map<String, dynamic>? from;
  Map<String, dynamic>? to;
  String? job;
  String? paymentTerms;
  int? discount;
  double? salesTax;
  String? currency;
  List<Map<String, dynamic>> items;

  InvoicegeneratorRequest({
    required this.invoiceNumber,
    this.date,
    this.dueDate,
    this.from,
    this.to,
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
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (job != null) 'job': job,
      if (paymentTerms != null) 'paymentTerms': paymentTerms,
      if (discount != null) 'discount': discount,
      if (salesTax != null) 'salesTax': salesTax,
      if (currency != null) 'currency': currency,
      'items': items,
    };
}
