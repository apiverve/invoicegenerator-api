"""
Invoice Generator API - Basic Usage Example

This example demonstrates the basic usage of the Invoice Generator API.
API Documentation: https://docs.apiverve.com/ref/invoicegenerator
"""

import os
import requests
import json

API_KEY = os.getenv('APIVERVE_API_KEY', 'YOUR_API_KEY_HERE')
API_URL = 'https://api.apiverve.com/v1/invoicegenerator'

def call_invoicegenerator_api():
    """
    Make a POST request to the Invoice Generator API
    """
    try:
        # Request body
        request_body &#x3D; {
    &#x27;invoiceNumber&#x27;: &#x27;INV000001&#x27;,
    &#x27;date&#x27;: &#x27;2025-02-01&#x27;,
    &#x27;dueDate&#x27;: &#x27;2025-11-30&#x27;,
    &#x27;from_name&#x27;: &#x27;John Doe&#x27;,
    &#x27;from_street&#x27;: &#x27;123 Elm St&#x27;,
    &#x27;from_city&#x27;: &#x27;Springfield&#x27;,
    &#x27;from_state&#x27;: &#x27;IL&#x27;,
    &#x27;from_zip&#x27;: &#x27;62701&#x27;,
    &#x27;to_name&#x27;: &#x27;Jane Smith&#x27;,
    &#x27;to_street&#x27;: &#x27;456 Oak St&#x27;,
    &#x27;to_city&#x27;: &#x27;Springfield&#x27;,
    &#x27;to_state&#x27;: &#x27;IL&#x27;,
    &#x27;to_zip&#x27;: &#x27;62702&#x27;,
    &#x27;job&#x27;: &#x27;Web Development&#x27;,
    &#x27;paymentTerms&#x27;: &#x27;Net 30&#x27;,
    &#x27;discount&#x27;: 10,
    &#x27;salesTax&#x27;: 37.07,
    &#x27;currency&#x27;: &#x27;USD&#x27;,
    &#x27;items&#x27;: [
        {
            &#x27;qty&#x27;: 2,
            &#x27;description&#x27;: &#x27;Web Design Services&#x27;,
            &#x27;unit_price&#x27;: 500
        },
        {
            &#x27;qty&#x27;: 1,
            &#x27;description&#x27;: &#x27;Domain Registration&#x27;,
            &#x27;unit_price&#x27;: 100
        }
    ]
}

        headers = {
            'x-api-key': API_KEY,
            'Content-Type': 'application/json'
        }

        response = requests.post(API_URL, headers=headers, json=request_body)

        # Raise exception for HTTP errors
        response.raise_for_status()

        data = response.json()

        # Check API response status
        if data.get('status') == 'ok':
            print('✓ Success!')
            print('Response data:', json.dumps(data['data'], indent=2))
            return data['data']
        else:
            print('✗ API Error:', data.get('error', 'Unknown error'))
            return None

    except requests.exceptions.RequestException as e:
        print(f'✗ Request failed: {e}')
        return None

if __name__ == '__main__':
    print('📤 Calling Invoice Generator API...\n')

    result = call_invoicegenerator_api()

    if result:
        print('\n📊 Final Result:')
        print(json.dumps(result, indent=2))
    else:
        print('\n✗ API call failed')
