# Invoice Generator API - Dart/Flutter Client

Invoice Generator is a simple tool for generating invoices. It returns a PDF of the generated invoice.

[![pub package](https://img.shields.io/pub/v/apiverve_invoicegenerator.svg)](https://pub.dev/packages/apiverve_invoicegenerator)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is the Dart/Flutter client for the [Invoice Generator API](https://apiverve.com/marketplace/invoicegenerator?utm_source=dart&utm_medium=readme).

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  apiverve_invoicegenerator: ^1.1.14
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
      'from': [object Object],
      'to': [object Object],
      'job': 'Web Development',
      'paymentTerms': 'Net 30',
      'discount': 10,
      'salesTax': 37.07,
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
    "pdfName": "f9210db5-8be3-4de4-8b20-d58019b0600a.pdf",
    "expires": 1740259902629,
    "downloadURL": "https://storage.googleapis.com/apiverve-helpers.appspot.com/htmltopdf/f9210db5-8be3-4de4-8b20-d58019b0600a.pdf?GoogleAccessId=1089020767582-compute%40developer.gserviceaccount.com&Expires=1740259902&Signature=PVHHoAfVg%2BUOXCC1kt3m3ttRAns6UTrYPm8%2BVS19hEFAH27VG%2FnZHgUl75iUYpZozqycZw7etohyekZIBPeqozfFWkkodkMvi487x2onk%2B3S9nQN5J0gmPxhcfWVjT4jPxk7ggQMhG2rl7QCxjAhG9OGo1U9OuhSYdJXaQqEmOMhTDkhW%2BB3RFMHqXmgYZHBLo8kh1aLLK%2FdKbGOF5ofR33W0w%2F5ywdykG%2BAnk0Rv3oxTIppAR%2F4NsDeqhYBgq3yXyRubOgcZGBEEtAj2bpYPuzNtqKgF7aENTQe4MkghWct8P4qs%2F8MDSSMCZCN1B24Xz8TxGGem814qThfv3DLOw%3D%3D"
  }
}
```

## API Reference

- **API Home:** [Invoice Generator API](https://apiverve.com/marketplace/invoicegenerator?utm_source=dart&utm_medium=readme)
- **Documentation:** [docs.apiverve.com/ref/invoicegenerator](https://docs.apiverve.com/ref/invoicegenerator?utm_source=dart&utm_medium=readme)

## Authentication

All requests require an API key. Get yours at [apiverve.com](https://apiverve.com?utm_source=dart&utm_medium=readme).

## License

MIT License - see [LICENSE](LICENSE) for details.

---

Built with Dart for [APIVerve](https://apiverve.com?utm_source=dart&utm_medium=readme)
