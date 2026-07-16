# Invoice Generator API - PHP Package

Invoice Generator is a simple tool for generating invoices. It returns a PDF of the generated invoice.

## Installation

Install via Composer:

```bash
composer require apiverve/invoicegenerator
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```php
<?php

require_once 'vendor/autoload.php';

use APIVerve\Invoicegenerator\Client;

// Initialize the client
$client = new Client('YOUR_API_KEY');

// Make a request
$response = $client->execute([
    'invoiceNumber' => 'INV000001',
    'date' => '2025-02-01',
    'dueDate' => '2025-11-30',
    'from_name' => 'John Doe',
    'from_street' => '123 Elm St',
    'from_city' => 'Springfield',
    'from_state' => 'IL',
    'from_zip' => '62701',
    'to_name' => 'Jane Smith',
    'to_street' => '456 Oak St',
    'to_city' => 'Springfield',
    'to_state' => 'IL',
    'to_zip' => '62702',
    'job' => 'Web Development',
    'paymentTerms' => 'Net 30',
    'discount' => 10,
    'salesTax' => 37.07,
    'currency' => 'USD',
    'items' => [object Object],[object Object]
]);

// Print the response
print_r($response);
```


### Error Handling

```php
use APIVerve\Invoicegenerator\Client;
use APIVerve\Invoicegenerator\Exceptions\APIException;
use APIVerve\Invoicegenerator\Exceptions\ValidationException;

try {
    $response = $client->execute(['invoiceNumber' => 'INV000001', 'date' => '2025-02-01', 'dueDate' => '2025-11-30', 'from_name' => 'John Doe', 'from_street' => '123 Elm St', 'from_city' => 'Springfield', 'from_state' => 'IL', 'from_zip' => '62701', 'to_name' => 'Jane Smith', 'to_street' => '456 Oak St', 'to_city' => 'Springfield', 'to_state' => 'IL', 'to_zip' => '62702', 'job' => 'Web Development', 'paymentTerms' => 'Net 30', 'discount' => 10, 'salesTax' => 37.07, 'currency' => 'USD', 'items' => [object Object],[object Object]]);
    print_r($response['data']);
} catch (ValidationException $e) {
    echo "Validation error: " . implode(', ', $e->getErrors());
} catch (APIException $e) {
    echo "API error: " . $e->getMessage();
    echo "Status code: " . $e->getStatusCode();
}
```

### Debug Mode

```php
// Enable debug logging
$client = new Client(
    apiKey: 'YOUR_API_KEY',
    debug: true
);
```

## Example Response

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

## Requirements

- PHP 7.4 or higher
- Guzzle HTTP client

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/invoicegenerator?utm_source=packagist&utm_medium=readme).

## Support

- Website: [https://apiverve.com/marketplace/invoicegenerator?utm_source=php&utm_medium=readme](https://apiverve.com/marketplace/invoicegenerator?utm_source=php&utm_medium=readme)
- Email: hello@apiverve.com

## License

This package is available under the [MIT License](LICENSE).
