interface Sale {
  id: number;
  products: {[key: string]: string} 
  player: number|string;
  commands: string[];
  delivery: boolean;
}

interface StatusResponse {
  plan: String;
  remaining: number;
  hours: number;
}

interface FetchResponse {
  approved: Sale[];
  refunded: Sale[];
  widgets: {[key: string]: boolean};
  elapsed: number;
}

interface CallbackResponse {
  count: number;
  elapsed: number;
}