using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace APIVerve.API.InvoiceGenerator
{
    /// <summary>
    /// Query options for the Invoice Generator API
    /// </summary>
    public class InvoiceGeneratorQueryOptions
    {
        /// <summary>
        /// The invoice number
        /// </summary>
        [JsonProperty("invoiceNumber")]
        public string InvoiceNumber { get; set; }

        /// <summary>
        /// The invoice date (YYYY-MM-DD format)
        /// </summary>
        [JsonProperty("date")]
        public string Date { get; set; }

        /// <summary>
        /// The name of the person or company issuing the invoice
        /// </summary>
        [JsonProperty("from_name")]
        public string From_name { get; set; }

        /// <summary>
        /// The street address of the person or company issuing the invoice
        /// </summary>
        [JsonProperty("from_street")]
        public string From_street { get; set; }

        /// <summary>
        /// The city of the person or company issuing the invoice
        /// </summary>
        [JsonProperty("from_city")]
        public string From_city { get; set; }

        /// <summary>
        /// The state of the person or company issuing the invoice
        /// </summary>
        [JsonProperty("from_state")]
        public string From_state { get; set; }

        /// <summary>
        /// The zip code of the person or company issuing the invoice
        /// </summary>
        [JsonProperty("from_zip")]
        public string From_zip { get; set; }

        /// <summary>
        /// The name of the person or company being invoiced
        /// </summary>
        [JsonProperty("to_name")]
        public string To_name { get; set; }

        /// <summary>
        /// The street address of the person or company being invoiced
        /// </summary>
        [JsonProperty("to_street")]
        public string To_street { get; set; }

        /// <summary>
        /// The city of the person or company being invoiced
        /// </summary>
        [JsonProperty("to_city")]
        public string To_city { get; set; }

        /// <summary>
        /// The state of the person or company being invoiced
        /// </summary>
        [JsonProperty("to_state")]
        public string To_state { get; set; }

        /// <summary>
        /// The zip code of the person or company being invoiced
        /// </summary>
        [JsonProperty("to_zip")]
        public string To_zip { get; set; }

        /// <summary>
        /// The job or project associated with the invoice
        /// </summary>
        [JsonProperty("job")]
        public string Job { get; set; }

        /// <summary>
        /// The payment terms for the invoice
        /// </summary>
        [JsonProperty("paymentTerms")]
        public string PaymentTerms { get; set; }

        /// <summary>
        /// The due date for the invoice (YYYY-MM-DD format)
        /// </summary>
        [JsonProperty("dueDate")]
        public string DueDate { get; set; }

        /// <summary>
        /// The discount to be applied to the invoice
        /// </summary>
        [JsonProperty("discount")]
        public string Discount { get; set; }

        /// <summary>
        /// The sales tax rate for the invoice (as percentage)
        /// </summary>
        [JsonProperty("salesTax")]
        public string SalesTax { get; set; }

        /// <summary>
        /// The currency for the invoice
        /// </summary>
        [JsonProperty("currency")]
        public string Currency { get; set; }

        /// <summary>
        /// The items being invoiced (qty, description, unit_price)
        /// </summary>
        [JsonProperty("items")]
        public string Items { get; set; }
    }
}
