// Package invoicegenerator provides a Go client for the Invoice Generator API.
//
// For more information, visit: https://apiverve.com/marketplace/invoicegenerator?utm_source=go&utm_medium=readme
package invoicegenerator

import (
	"fmt"
	"reflect"
	"regexp"
	"strings"
)

// ValidationRule defines validation constraints for a parameter.
type ValidationRule struct {
	Type      string
	Required  bool
	Min       *float64
	Max       *float64
	MinLength *int
	MaxLength *int
	Format    string
	Enum      []string
}

// ValidationError represents a parameter validation error.
type ValidationError struct {
	Errors []string
}

func (e *ValidationError) Error() string {
	return "Validation failed: " + strings.Join(e.Errors, "; ")
}

// Helper functions for pointers
func float64Ptr(v float64) *float64 { return &v }
func intPtr(v int) *int             { return &v }

// Format validation patterns
var formatPatterns = map[string]*regexp.Regexp{
	"email":    regexp.MustCompile(`^[^\s@]+@[^\s@]+\.[^\s@]+$`),
	"url":      regexp.MustCompile(`^https?://.+`),
	"ip":       regexp.MustCompile(`^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`),
	"date":     regexp.MustCompile(`^\d{4}-\d{2}-\d{2}$`),
	"hexColor": regexp.MustCompile(`^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$`),
}

// Request contains the parameters for the Invoice Generator API.
//
// Parameters:
//   - invoiceNumber (required): string - The invoice number
//   - date: string - The invoice date (YYYY-MM-DD format) [format: date]
//   - from_name (required): string - The name of the person or company issuing the invoice
//   - from_street (required): string - The street address of the person or company issuing the invoice
//   - from_city (required): string - The city of the person or company issuing the invoice
//   - from_state (required): string - The state of the person or company issuing the invoice [maxLength: 2]
//   - from_zip (required): string - The zip code of the person or company issuing the invoice [minLength: 5, maxLength: 10]
//   - to_name (required): string - The name of the person or company being invoiced
//   - to_street (required): string - The street address of the person or company being invoiced
//   - to_city (required): string - The city of the person or company being invoiced
//   - to_state (required): string - The state of the person or company being invoiced [maxLength: 2]
//   - to_zip (required): string - The zip code of the person or company being invoiced [minLength: 5, maxLength: 10]
//   - job: string - The job or project associated with the invoice
//   - paymentTerms: string - The payment terms for the invoice
//   - dueDate: string - The due date for the invoice (YYYY-MM-DD format) [format: date]
//   - discount: number - The discount to be applied to the invoice [min: 0]
//   - salesTax: number - The sales tax rate for the invoice (as percentage) [min: 0, max: 100]
//   - currency: string - The currency for the invoice
//   - items (required): array - The items being invoiced (qty, description, unit_price)
type Request struct {
	InvoiceNumber string `json:"invoiceNumber"` // Required
	Date string `json:"date,omitempty"` // Optional
	DueDate string `json:"dueDate,omitempty"` // Optional
	From map[string]interface{} `json:"from,omitempty"` // Optional
	To map[string]interface{} `json:"to,omitempty"` // Optional
	Job string `json:"job,omitempty"` // Optional
	PaymentTerms string `json:"paymentTerms,omitempty"` // Optional
	Discount int `json:"discount,omitempty"` // Optional
	SalesTax float64 `json:"salesTax,omitempty"` // Optional
	Currency string `json:"currency,omitempty"` // Optional
	Items []map[string]interface{} `json:"items"` // Required
}

// ToQueryParams converts the request struct to a map of query parameters.
// Only non-zero values are included.
func (r *Request) ToQueryParams() map[string]string {
	params := make(map[string]string)
	if r == nil {
		return params
	}

	v := reflect.ValueOf(*r)
	t := v.Type()

	for i := 0; i < v.NumField(); i++ {
		field := v.Field(i)
		fieldType := t.Field(i)

		// Get the json tag for the field name
		jsonTag := fieldType.Tag.Get("json")
		if jsonTag == "" {
			continue
		}
		// Handle tags like `json:"name,omitempty"`
		jsonName := strings.Split(jsonTag, ",")[0]
		if jsonName == "-" {
			continue
		}

		// Skip zero values
		if field.IsZero() {
			continue
		}

		// Convert to string
		params[jsonName] = fmt.Sprintf("%v", field.Interface())
	}

	return params
}

// Validate checks the request parameters against validation rules.
// Returns a ValidationError if validation fails, nil otherwise.
func (r *Request) Validate() error {
	rules := map[string]ValidationRule{
		"invoiceNumber": {Type: "string", Required: true},
		"date": {Type: "string", Required: false, Format: "date"},
		"from_name": {Type: "string", Required: true},
		"from_street": {Type: "string", Required: true},
		"from_city": {Type: "string", Required: true},
		"from_state": {Type: "string", Required: true, MaxLength: intPtr(2)},
		"from_zip": {Type: "string", Required: true, MinLength: intPtr(5), MaxLength: intPtr(10)},
		"to_name": {Type: "string", Required: true},
		"to_street": {Type: "string", Required: true},
		"to_city": {Type: "string", Required: true},
		"to_state": {Type: "string", Required: true, MaxLength: intPtr(2)},
		"to_zip": {Type: "string", Required: true, MinLength: intPtr(5), MaxLength: intPtr(10)},
		"job": {Type: "string", Required: false},
		"paymentTerms": {Type: "string", Required: false},
		"dueDate": {Type: "string", Required: false, Format: "date"},
		"discount": {Type: "number", Required: false, Min: float64Ptr(0)},
		"salesTax": {Type: "number", Required: false, Min: float64Ptr(0), Max: float64Ptr(100)},
		"currency": {Type: "string", Required: false},
		"items": {Type: "array", Required: true},
	}

	if len(rules) == 0 {
		return nil
	}

	var errors []string
	v := reflect.ValueOf(*r)
	t := v.Type()

	for i := 0; i < v.NumField(); i++ {
		field := v.Field(i)
		fieldType := t.Field(i)

		jsonTag := fieldType.Tag.Get("json")
		if jsonTag == "" {
			continue
		}
		jsonName := strings.Split(jsonTag, ",")[0]

		rule, exists := rules[jsonName]
		if !exists {
			continue
		}

		// Check required
		if rule.Required && field.IsZero() {
			errors = append(errors, fmt.Sprintf("Required parameter [%s] is missing", jsonName))
			continue
		}

		if field.IsZero() {
			continue
		}

		// Type-specific validation
		switch rule.Type {
		case "integer", "number":
			var numVal float64
			switch field.Kind() {
			case reflect.Int, reflect.Int64:
				numVal = float64(field.Int())
			case reflect.Float64:
				numVal = field.Float()
			}
			if rule.Min != nil && numVal < *rule.Min {
				errors = append(errors, fmt.Sprintf("Parameter [%s] must be at least %v", jsonName, *rule.Min))
			}
			if rule.Max != nil && numVal > *rule.Max {
				errors = append(errors, fmt.Sprintf("Parameter [%s] must be at most %v", jsonName, *rule.Max))
			}

		case "string":
			strVal := field.String()
			if rule.MinLength != nil && len(strVal) < *rule.MinLength {
				errors = append(errors, fmt.Sprintf("Parameter [%s] must be at least %d characters", jsonName, *rule.MinLength))
			}
			if rule.MaxLength != nil && len(strVal) > *rule.MaxLength {
				errors = append(errors, fmt.Sprintf("Parameter [%s] must be at most %d characters", jsonName, *rule.MaxLength))
			}
			if rule.Format != "" {
				if pattern, ok := formatPatterns[rule.Format]; ok {
					if !pattern.MatchString(strVal) {
						errors = append(errors, fmt.Sprintf("Parameter [%s] must be a valid %s", jsonName, rule.Format))
					}
				}
			}
		}

		// Enum validation
		if len(rule.Enum) > 0 {
			strVal := fmt.Sprintf("%v", field.Interface())
			found := false
			for _, enumVal := range rule.Enum {
				if strVal == enumVal {
					found = true
					break
				}
			}
			if !found {
				errors = append(errors, fmt.Sprintf("Parameter [%s] must be one of: %s", jsonName, strings.Join(rule.Enum, ", ")))
			}
		}
	}

	if len(errors) > 0 {
		return &ValidationError{Errors: errors}
	}
	return nil
}

// ResponseData contains the data returned by the Invoice Generator API.
type ResponseData struct {
	PdfName string `json:"pdfName"`
	Expires int `json:"expires"`
	DownloadURL string `json:"downloadURL"`
}

