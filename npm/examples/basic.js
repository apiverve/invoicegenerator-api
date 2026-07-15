/**
 * Basic Example - Invoice Generator API
 *
 * This example demonstrates how to use the Invoice Generator API.
 * Make sure to set your API key in the .env file or replace '[YOUR_API_KEY]' below.
 */

require('dotenv').config();
const invoicegeneratorAPI = require('../index.js');

// Initialize the API client
const api = new invoicegeneratorAPI({
    api_key: process.env.API_KEY || '[YOUR_API_KEY]'
});

// Example query
var query = {
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
  "salesTax": 37.07,
  "currency": "USD",
  "items": [
    {
      "qty": 2,
      "description": "Web Design Services",
      "unit_price": 500
    },
    {
      "qty": 1,
      "description": "Domain Registration",
      "unit_price": 100
    }
  ]
};

// Make the API request using callback
console.log('Making request to Invoice Generator API...\n');

api.execute(query, function (error, data) {
    if (error) {
        console.error('Error occurred:');
        if (error.error) {
            console.error('Message:', error.error);
            console.error('Status:', error.status);
        } else {
            console.error(JSON.stringify(error, null, 2));
        }
        return;
    }

    console.log('Response:');
    console.log(JSON.stringify(data, null, 2));
});
