declare module '@apiverve/invoicegenerator' {
  export interface invoicegeneratorOptions {
    api_key: string;
    secure?: boolean;
  }

  /**
   * Describes fields the current plan does not unlock. Locked fields arrive as null
   * in `data`; `locked_fields` names them, using dot paths for nested fields.
   * Absent when the plan unlocks everything.
   */
  export interface PremiumInfo {
    message: string;
    upgrade_url: string;
    locked_fields: string[];
  }

  export interface invoicegeneratorResponse {
    status: string;
    error: string | null;
    data: InvoiceGeneratorData;
    code?: number;
    premium?: PremiumInfo;
  }


  interface InvoiceGeneratorData {
      pdfName:     null | string;
      expires:     number | null;
      downloadURL: null | string;
  }

  export default class invoicegeneratorWrapper {
    constructor(options: invoicegeneratorOptions);

    execute(callback: (error: any, data: invoicegeneratorResponse | null) => void): Promise<invoicegeneratorResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: invoicegeneratorResponse | null) => void): Promise<invoicegeneratorResponse>;
    execute(query?: Record<string, any>): Promise<invoicegeneratorResponse>;
  }
}
