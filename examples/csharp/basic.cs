/*
 * Invoice Generator API - Basic Usage Example
 *
 * This example demonstrates the basic usage of the Invoice Generator API.
 * API Documentation: https://docs.apiverve.com/ref/invoicegenerator
 */

using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Linq;

namespace APIVerve.Examples
{
    class InvoiceGeneratorExample
    {
        private static readonly string API_KEY = Environment.GetEnvironmentVariable("APIVERVE_API_KEY") ?? "YOUR_API_KEY_HERE";
        private static readonly string API_URL = "https://api.apiverve.com/v1/invoicegenerator";

        /// <summary>
        /// Make a POST request to the Invoice Generator API
        /// </summary>
        static async Task<JsonDocument> CallInvoiceGeneratorAPI()
        {
            try
            {
                using var client = new HttpClient();
                client.DefaultRequestHeaders.Add("x-api-key", API_KEY);

                // Request body
                var requestBody &#x3D; new { invoiceNumber &#x3D; &quot;INV000001&quot;, date &#x3D; &quot;2025-02-01&quot;, dueDate &#x3D; &quot;2025-11-30&quot;, from_name &#x3D; &quot;John Doe&quot;, from_street &#x3D; &quot;123 Elm St&quot;, from_city &#x3D; &quot;Springfield&quot;, from_state &#x3D; &quot;IL&quot;, from_zip &#x3D; &quot;62701&quot;, to_name &#x3D; &quot;Jane Smith&quot;, to_street &#x3D; &quot;456 Oak St&quot;, to_city &#x3D; &quot;Springfield&quot;, to_state &#x3D; &quot;IL&quot;, to_zip &#x3D; &quot;62702&quot;, job &#x3D; &quot;Web Development&quot;, paymentTerms &#x3D; &quot;Net 30&quot;, discount &#x3D; 10, salesTax &#x3D; 37.07, currency &#x3D; &quot;USD&quot;, items &#x3D; [object Object],[object Object] };

                var jsonContent = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

                var response = await client.PostAsync(API_URL, content);

                // Check if response is successful
                response.EnsureSuccessStatusCode();

                var responseBody = await response.Content.ReadAsStringAsync();
                var data = JsonDocument.Parse(responseBody);

                // Check API response status
                if (data.RootElement.GetProperty("status").GetString() == "ok")
                {
                    Console.WriteLine("✓ Success!");
                    Console.WriteLine("Response data: " + data.RootElement.GetProperty("data"));
                    return data;
                }
                else
                {
                    var error = data.RootElement.TryGetProperty("error", out var errorProp)
                        ? errorProp.GetString()
                        : "Unknown error";
                    Console.WriteLine($"✗ API Error: {error}");
                    return null;
                }
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine($"✗ Request failed: {e.Message}");
                return null;
            }
        }

        static async Task Main(string[] args)
        {
            Console.WriteLine("📤 Calling Invoice Generator API...\n");

            var result = await CallInvoiceGeneratorAPI();

            if (result != null)
            {
                Console.WriteLine("\n📊 Final Result:");
                Console.WriteLine(result.RootElement.GetProperty("data"));
            }
            else
            {
                Console.WriteLine("\n✗ API call failed");
            }
        }
    }
}
