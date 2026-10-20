Invoice Generator API
============

Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms. It computes subtotals with discounts and sales tax, returning an expiring download link.


[![PyPI version](https://img.shields.io/pypi/v/apiverve-invoicegenerator.svg)](https://pypi.org/project/apiverve-invoicegenerator/)

This is a Python wrapper for the [Invoice Generator API](https://apiverve.com/marketplace/invoicegenerator?utm_source=pypi&utm_medium=referral&utm_content=readme)

---

## Installation

Using `pip`:

```bash
pip install apiverve-invoicegenerator
```

Using `pip3`:

```bash
pip3 install apiverve-invoicegenerator
```

---

## Configuration

Before using the Invoice Generator API client, you have to setup your account and obtain your API Key.
You can get it by signing up at [https://apiverve.com](https://apiverve.com?utm_source=pypi&utm_medium=referral&utm_content=readme)

---

## Quick Start

Here's a simple example to get you started quickly:

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient

# Initialize the client with your APIVerve API key
api = InvoicegeneratorAPIClient("[YOUR_API_KEY]")

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

try:
    # Make the API call
    result = api.execute(query)

    # Print the result
    print(result)
except Exception as e:
    print(f"Error: {e}")
```

---

## Usage

The Invoice Generator API documentation is found here: [https://docs.apiverve.com/ref/invoicegenerator](https://docs.apiverve.com/ref/invoicegenerator?utm_source=pypi&utm_medium=referral&utm_content=readme).
You can find parameters, example responses, and status codes documented here.

### Setup

```python
# Import the client module
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient

# Initialize the client with your APIVerve API key
api = InvoicegeneratorAPIClient("[YOUR_API_KEY]")
```

---

## Perform Request

Using the API client, you can perform requests to the API.

###### Define Query

```python
query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}
```

###### Simple Request

```python
# Make a request to the API
result = api.execute(query)

# Print the result
print(result)
```

###### Example Response

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

---

## Error Handling

The API client provides comprehensive error handling through the `InvoicegeneratorAPIClientError` exception. Here are some examples:

### Basic Error Handling

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient, InvoicegeneratorAPIClientError

api = InvoicegeneratorAPIClient("[YOUR_API_KEY]")

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

try:
    result = api.execute(query)
    print("Success!")
    print(result)
except InvoicegeneratorAPIClientError as e:
    print(f"API Error: {e.message}")
    if e.status_code:
        print(f"Status Code: {e.status_code}")
    if e.response:
        print(f"Response: {e.response}")
```

### Handling Specific Error Types

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient, InvoicegeneratorAPIClientError

api = InvoicegeneratorAPIClient("[YOUR_API_KEY]")

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

try:
    result = api.execute(query)

    # Check for successful response
    if result.get('status') == 'success':
        print("Request successful!")
        print(result.get('data'))
    else:
        print(f"API returned an error: {result.get('error')}")

except InvoicegeneratorAPIClientError as e:
    # Handle API client errors
    if e.status_code == 401:
        print("Unauthorized: Invalid API key")
    elif e.status_code == 429:
        print("Rate limit exceeded")
    elif e.status_code >= 500:
        print("Server error - please try again later")
    else:
        print(f"API error: {e.message}")
except Exception as e:
    # Handle unexpected errors
    print(f"Unexpected error: {str(e)}")
```

### Using Context Manager (Recommended)

The client supports the context manager protocol for automatic resource cleanup:

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient, InvoicegeneratorAPIClientError

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

# Using context manager ensures proper cleanup
with InvoicegeneratorAPIClient("[YOUR_API_KEY]") as api:
    try:
        result = api.execute(query)
        print(result)
    except InvoicegeneratorAPIClientError as e:
        print(f"Error: {e.message}")
# Session is automatically closed here
```

---

## Advanced Features

### Debug Mode

Enable debug logging to see detailed request and response information:

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient

# Enable debug mode
api = InvoicegeneratorAPIClient("[YOUR_API_KEY]", debug=True)

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

# Debug information will be printed to console
result = api.execute(query)
```

### Manual Session Management

If you need to manually manage the session lifecycle:

```python
from apiverve_invoicegenerator.apiClient import InvoicegeneratorAPIClient

api = InvoicegeneratorAPIClient("[YOUR_API_KEY]")

query = {
    "invoiceNumber": "INV000001",
    "date": "2025-02-01",
    "dueDate": "2025-11-30",
    "from_name": "John Doe",
    "from_street": "123 Elm St",
    "from_city": "Springfield",
    "from_state": "IL",
    "from_zip": "62701",
    "to_name": "Jane Smith",
    "to_street": "456 Oak St",
    "to_city": "Springfield",
    "to_state": "IL",
    "to_zip": "62702",
    "job": "Web Development",
    "paymentTerms": "Net 30",
    "discount": 10,
    "salesTax": 7.5,
    "currency": "USD",
    "items": [{"qty":2,"description":"Web Design Services","unit_price":500},{"qty":1,"description":"Domain Registration","unit_price":100}]
}

try:
    result = api.execute(query)
    print(result)
finally:
    # Manually close the session when done
    api.close()
```

---

## Customer Support

Need any assistance? [Get in touch with Customer Support](https://apiverve.com/contact?utm_source=pypi&utm_medium=referral&utm_content=readme).

---

## Updates
Stay up to date by following [@apiverveHQ](https://twitter.com/apiverveHQ) on Twitter.

---

## Legal

All usage of the APIVerve website, API, and services is subject to the [APIVerve Terms of Service](https://apiverve.com/terms?utm_source=pypi&utm_medium=referral&utm_content=readme) and all legal documents and agreements.

---

## License
Licensed under the MIT License (MIT)

Copyright (&copy;) 2026 APIVerve, and EvlarSoft LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
