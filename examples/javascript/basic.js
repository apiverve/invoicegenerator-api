/**
 * Invoice Generator API - Basic Usage Example
 *
 * This example demonstrates the basic usage of the Invoice Generator API.
 * API Documentation: https://docs.apiverve.com/ref/invoicegenerator
 */

const API_KEY = process.env.APIVERVE_API_KEY || 'YOUR_API_KEY_HERE';
const API_URL = 'https://api.apiverve.com/v1/invoicegenerator';

/**
 * Make a POST request to the Invoice Generator API
 */
async function callInvoiceGeneratorAPI() {
  try {
    // Request body
    const requestBody &#x3D; {
    &quot;invoiceNumber&quot;: &quot;INV000001&quot;,
    &quot;date&quot;: &quot;2025-02-01&quot;,
    &quot;dueDate&quot;: &quot;2025-11-30&quot;,
    &quot;from_name&quot;: &quot;John Doe&quot;,
    &quot;from_street&quot;: &quot;123 Elm St&quot;,
    &quot;from_city&quot;: &quot;Springfield&quot;,
    &quot;from_state&quot;: &quot;IL&quot;,
    &quot;from_zip&quot;: &quot;62701&quot;,
    &quot;to_name&quot;: &quot;Jane Smith&quot;,
    &quot;to_street&quot;: &quot;456 Oak St&quot;,
    &quot;to_city&quot;: &quot;Springfield&quot;,
    &quot;to_state&quot;: &quot;IL&quot;,
    &quot;to_zip&quot;: &quot;62702&quot;,
    &quot;job&quot;: &quot;Web Development&quot;,
    &quot;paymentTerms&quot;: &quot;Net 30&quot;,
    &quot;discount&quot;: 10,
    &quot;salesTax&quot;: 37.07,
    &quot;currency&quot;: &quot;USD&quot;,
    &quot;items&quot;: [
        {
            &quot;qty&quot;: 2,
            &quot;description&quot;: &quot;Web Design Services&quot;,
            &quot;unit_price&quot;: 500
        },
        {
            &quot;qty&quot;: 1,
            &quot;description&quot;: &quot;Domain Registration&quot;,
            &quot;unit_price&quot;: 100
        }
    ]
};

    const response = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'x-api-key': API_KEY,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(requestBody)
    });

    // Check if response is successful
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();

    // Check API response status
    if (data.status === 'ok') {
      console.log('✓ Success!');
      console.log('Response data:', data.data);
      return data.data;
    } else {
      console.error('✗ API Error:', data.error || 'Unknown error');
      return null;
    }

  } catch (error) {
    console.error('✗ Request failed:', error.message);
    return null;
  }
}

// Run the example
callInvoiceGeneratorAPI()
  .then(result => {
    if (result) {
      console.log('\n📊 Final Result:');
      console.log(JSON.stringify(result, null, 2));
    }
  });
