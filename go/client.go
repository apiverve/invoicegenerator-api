// Package invoicegenerator provides a Go client for the Invoice Generator API.
//
// For more information, visit: https://apiverve.com/marketplace/invoicegenerator?utm_source=go&utm_medium=readme
package invoicegenerator

import (
	"errors"
	"fmt"
	"time"

	"github.com/go-resty/resty/v2"
)

const (
	baseURL        = "https://api.apiverve.com/v1/invoicegenerator"
	defaultTimeout = 30 * time.Second
)

// Client is the Invoice Generator API client.
type Client struct {
	apiKey     string
	httpClient *resty.Client
}

// NewClient creates a new Invoice Generator API client.
func NewClient(apiKey string) *Client {
	client := resty.New()
	client.SetTimeout(defaultTimeout)
	client.SetHeader("Content-Type", "application/json")

	return &Client{
		apiKey:     apiKey,
		httpClient: client,
	}
}

// SetTimeout sets the HTTP client timeout.
func (c *Client) SetTimeout(timeout time.Duration) {
	c.httpClient.SetTimeout(timeout)
}


// Execute makes a request to the Invoice Generator API with typed parameters.
//
// Parameters are validated before sending the request. If validation fails,
// an error is returned immediately without making a network request.
//
// Available parameters:
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
func (c *Client) Execute(req *Request) (*Response, error) {
	if c.apiKey == "" {
		return nil, errors.New("API key is required. Get your API key at: https://apiverve.com")
	}

	// Validate parameters before making request
	if req != nil {
		if err := req.Validate(); err != nil {
			return nil, err
		}
	}

	request := c.httpClient.R().
		SetHeader("x-api-key", c.apiKey).
		SetResult(&Response{}).
		SetError(&ErrorResponse{})

	// POST request with JSON body
	resp, err := request.
		SetBody(req).
		Post(baseURL)

	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}

	if resp.IsError() {
		if errResp, ok := resp.Error().(*ErrorResponse); ok {
			return nil, fmt.Errorf("API error: %s", errResp.Error)
		}
		return nil, fmt.Errorf("API error: status %d", resp.StatusCode())
	}

	result, ok := resp.Result().(*Response)
	if !ok {
		return nil, errors.New("failed to parse response")
	}

	return result, nil
}

// ExecuteRaw makes a request with a raw map of parameters (for dynamic usage).
func (c *Client) ExecuteRaw(params map[string]interface{}) (*Response, error) {
	if c.apiKey == "" {
		return nil, errors.New("API key is required. Get your API key at: https://apiverve.com")
	}

	request := c.httpClient.R().
		SetHeader("x-api-key", c.apiKey).
		SetResult(&Response{}).
		SetError(&ErrorResponse{})

	resp, err := request.
		SetBody(params).
		Post(baseURL)

	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}

	if resp.IsError() {
		if errResp, ok := resp.Error().(*ErrorResponse); ok {
			return nil, fmt.Errorf("API error: %s", errResp.Error)
		}
		return nil, fmt.Errorf("API error: status %d", resp.StatusCode())
	}

	result, ok := resp.Result().(*Response)
	if !ok {
		return nil, errors.New("failed to parse response")
	}

	return result, nil
}

// Response represents the API response.
type Response struct {
	Status string       `json:"status"`
	Error  interface{}  `json:"error"`
	Data   ResponseData `json:"data"`
}

// ErrorResponse represents an error response from the API.
type ErrorResponse struct {
	Status string `json:"status"`
	Error  string `json:"error"`
}
