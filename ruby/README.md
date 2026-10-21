# Invoice Generator API - Ruby Gem

Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms. It computes subtotals with discounts and sales tax, returning an expiring download link.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apiverve_invoicegenerator'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install apiverve_invoicegenerator
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```ruby
require 'apiverve_invoicegenerator'

# Initialize the client
client = APIVerve::Invoicegenerator::Client.new(api_key: "YOUR_API_KEY")

# Make a request
response = client.execute({
  invoiceNumber: "INV000001",
  date: "2025-02-01",
  dueDate: "2025-11-30",
  from_name: "John Doe",
  from_street: "123 Elm St",
  from_city: "Springfield",
  from_state: "IL",
  from_zip: "62701",
  to_name: "Jane Smith",
  to_street: "456 Oak St",
  to_city: "Springfield",
  to_state: "IL",
  to_zip: "62702",
  job: "Web Development",
  paymentTerms: "Net 30",
  discount: 10,
  salesTax: 7.5,
  currency: "USD",
  items: [object Object],[object Object]
})

# Print the response
puts response
```


### Error Handling

```ruby
begin
  response = client.execute({ invoiceNumber: "INV000001", date: "2025-02-01", dueDate: "2025-11-30", from_name: "John Doe", from_street: "123 Elm St", from_city: "Springfield", from_state: "IL", from_zip: "62701", to_name: "Jane Smith", to_street: "456 Oak St", to_city: "Springfield", to_state: "IL", to_zip: "62702", job: "Web Development", paymentTerms: "Net 30", discount: 10, salesTax: 7.5, currency: "USD", items: [object Object],[object Object] })
  puts response["data"]
rescue APIVerve::Invoicegenerator::ValidationError => e
  puts "Validation error: #{e.errors.join(', ')}"
rescue APIVerve::Invoicegenerator::APIError => e
  puts "API error: #{e.message}"
  puts "Status code: #{e.status_code}"
end
```

### Debug Mode

```ruby
# Enable debug logging
client = APIVerve::Invoicegenerator::Client.new(
  api_key: "YOUR_API_KEY",
  debug: true
)
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

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/invoicegenerator?utm_source=rubygems&utm_medium=referral&utm_content=readme).

## Support

- Website: [https://apiverve.com/marketplace/invoicegenerator?utm_source=ruby&utm_medium=referral&utm_content=readme](https://apiverve.com/marketplace/invoicegenerator?utm_source=ruby&utm_medium=referral&utm_content=readme)
- Email: hello@apiverve.com

## License

This gem is available under the [MIT License](LICENSE).
