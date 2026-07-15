import com.apiverve.invoicegenerator.InvoiceGeneratorAPIClient;
import com.apiverve.invoicegenerator.APIResponse;
import com.apiverve.invoicegenerator.APIException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class BasicExample {
    public static void main(String[] args) {
        // Initialize the API client with your API key
        InvoiceGeneratorAPIClient client = new InvoiceGeneratorAPIClient("YOUR_API_KEY_HERE");

        try {
            // Request body
            Map&lt;String, Object&gt; parameters &#x3D; new HashMap&lt;&gt;();
        parameters.put(&quot;invoiceNumber&quot;, &quot;INV000001&quot;);
        parameters.put(&quot;date&quot;, &quot;2025-02-01&quot;);
        parameters.put(&quot;dueDate&quot;, &quot;2025-11-30&quot;);
        parameters.put(&quot;from_name&quot;, &quot;John Doe&quot;);
        parameters.put(&quot;from_street&quot;, &quot;123 Elm St&quot;);
        parameters.put(&quot;from_city&quot;, &quot;Springfield&quot;);
        parameters.put(&quot;from_state&quot;, &quot;IL&quot;);
        parameters.put(&quot;from_zip&quot;, &quot;62701&quot;);
        parameters.put(&quot;to_name&quot;, &quot;Jane Smith&quot;);
        parameters.put(&quot;to_street&quot;, &quot;456 Oak St&quot;);
        parameters.put(&quot;to_city&quot;, &quot;Springfield&quot;);
        parameters.put(&quot;to_state&quot;, &quot;IL&quot;);
        parameters.put(&quot;to_zip&quot;, &quot;62702&quot;);
        parameters.put(&quot;job&quot;, &quot;Web Development&quot;);
        parameters.put(&quot;paymentTerms&quot;, &quot;Net 30&quot;);
        parameters.put(&quot;discount&quot;, 10);
        parameters.put(&quot;salesTax&quot;, 37.07);
        parameters.put(&quot;currency&quot;, &quot;USD&quot;);
        parameters.put(&quot;items&quot;, [object Object],[object Object]);

            // Execute the API request
            APIResponse response = client.execute(parameters);

            // Check if the request was successful
            if (response.isSuccess()) {
                System.out.println("✅ Success!");

                // Get the response data
                JSONObject data = response.getData();
                if (data != null) {
                    System.out.println("Response data:");
                    System.out.println(data.toString(2)); // Pretty print with 2-space indent
                }

                // Or get specific fields from the data
                // String value = data.optString("fieldName");

            } else {
                // Handle API errors
                System.err.println("❌ API Error: " + response.getError());
                System.err.println("Status: " + response.getStatus());
                System.err.println("Code: " + response.getCode());
            }

        } catch (APIException e) {
            // Handle exceptions
            System.err.println("❌ Error: " + e.getMessage());

            // Handle specific error types
            if (e.isAuthenticationError()) {
                System.err.println("Invalid API key. Get your key at: https://apiverve.com");
            } else if (e.isRateLimitError()) {
                System.err.println("Rate limit exceeded. Please try again later.");
            } else if (e.isServerError()) {
                System.err.println("Server error (5xx). Please try again later.");
            } else if (e.isClientError()) {
                System.err.println("Client error (4xx). Check your request parameters.");
            }

            // Get HTTP status code if available
            if (e.getStatusCode() > 0) {
                System.err.println("HTTP Status Code: " + e.getStatusCode());
            }
        }
    }
}
