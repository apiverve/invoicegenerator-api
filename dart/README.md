# Invoice Generator API - Dart/Flutter Client

Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms. It computes subtotals with discounts and sales tax, returning an expiring download link.

[![pub package](https://img.shields.io/pub/v/apiverve_invoicegenerator.svg)](https://pub.dev/packages/apiverve_invoicegenerator)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is the Dart/Flutter client for the [Invoice Generator API](https://apiverve.com/marketplace/invoicegenerator?utm_source=dart&utm_medium=referral&utm_content=readme).

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  apiverve_invoicegenerator: ^1.2.5
```

Then run:

```bash
dart pub get
# or for Flutter
flutter pub get
```

## Usage

```dart
import 'package:apiverve_invoicegenerator/apiverve_invoicegenerator.dart';

void main() async {
  final client = InvoicegeneratorClient('YOUR_API_KEY');

  try {
    final response = await client.execute({
      'invoiceNumber': 'INV000001',
      'date': '2025-02-01',
      'dueDate': '2025-11-30',
      'from_name': 'John Doe',
      'from_street': '123 Elm St',
      'from_city': 'Springfield',
      'from_state': 'IL',
      'from_zip': '62701',
      'to_name': 'Jane Smith',
      'to_street': '456 Oak St',
      'to_city': 'Springfield',
      'to_state': 'IL',
      'to_zip': '62702',
      'job': 'Web Development',
      'paymentTerms': 'Net 30',
      'discount': 10,
      'salesTax': 7.5,
      'currency': 'USD',
      'items': [object Object],[object Object]
    });

    print('Status: ${response.status}');
    print('Data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
```

## Response

```json
{
  "status": "ok",
  "error": null,
  "data": {
    "pdfName": "fc17c4bd-e660-4078-94ae-f46be56c9006.pdf",
    "expires": 1766096689189,
    "downloadURL": "https://storage.googleapis.com/apiverve-helpers.appspot.com/htmltopdf/fc17c4bd-e660-4078-94ae-f46be56c9006.pdf?GoogleAccessId=1089020767582-compute%40developer.gserviceaccount.com&Expires=1766096689&Signature=zZYB17Rj1yfbfhM3Epmjc9PEfmsVpgsCATX5%2Bx2yAo%2FV45xUatVzkAjUkPC48PkR4m%2BF7uIJBToUY2QAZMzNIOre4T0Md2eToXtcYF%2F%2FefS3sZocODRdiC%2BmEuMZjsAPMfkhbCMQZT4lZczQn9sfaWJlWJi%2FGWXKVUwZby3yn06Ed7OqianYbxQj87ENoqYudZFe5qFpI0hmwh4lBrnIM40hb4eZwwbGEvZL2WejNdBgD0cKb3C%2BHwJHkPvd2PAzFfNvuJolBxMN4jE3QCx9DN2MdHGUqb7t3vlP0Kder8m0lMpac%2BPbwZsDVmlF595cFzkKaE928uxzA1Mzkenffg%3D%3D"
  }
}
```

## API Reference

- **API Home:** [Invoice Generator API](https://apiverve.com/marketplace/invoicegenerator?utm_source=dart&utm_medium=referral&utm_content=readme)
- **Documentation:** [docs.apiverve.com/ref/invoicegenerator](https://docs.apiverve.com/ref/invoicegenerator?utm_source=dart&utm_medium=referral&utm_content=readme)

## Authentication

All requests require an API key. Get yours at [apiverve.com](https://apiverve.com?utm_source=dart&utm_medium=referral&utm_content=readme).

## License

MIT License - see [LICENSE](LICENSE) for details.

---

Built with Dart for [APIVerve](https://apiverve.com?utm_source=dart&utm_medium=referral&utm_content=readme)
