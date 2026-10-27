Pod::Spec.new do |s|
  s.name             = 'APIVerveInvoiceGenerator'
  s.version          = '1.2.3'
  s.summary          = 'Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms.'
  s.description      = <<-'DESC'
Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms. It computes subtotals with discounts and sales tax, returning an expiring download link.

This iOS/macOS SDK provides a convenient way to access the Invoice Generator from APIVerve.
Supports both callback-based and async/await patterns.
                       DESC

  s.homepage         = 'https://apiverve.com/marketplace/invoicegenerator?utm_source=cocoapods&utm_medium=referral&utm_content=homepage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'APIVerve' => 'hello@apiverve.com' }
  # The SDK repo holds every language; the pod lives under cocoapods/ with its own tag.
  s.source           = { :git => 'https://github.com/apiverve/invoicegenerator-api.git', :tag => "cocoapods/v#{s.version}" }

  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'

  s.swift_version = '5.0'

  s.source_files = 'cocoapods/Sources/APIVerveInvoiceGenerator/**/*.swift'

  s.frameworks = 'Foundation'

  # APIResponse, APIVerveError and the request plumbing, shared by every APIVerve pod.
  s.dependency 'APIVerveCore', '~> 1.2'
end
