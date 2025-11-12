const API_URL = import.meta.env.VITE_API_URL || "http://localhost:3000";
export type Payment = {
  id: string;
  amount_cents: number;
  currency: string;
  email: string;
  name: string;
  status: "created" | "authorized" | "captured" | "failed";
  created_at: string;
};
export async function listPayments(): Promise<Payment[]> {
  const res = await fetch(`${API_URL}/payments`);
  return res.json();
}
export async function createPayment(input: { amount_cents: number; currency: string; email: string; name: string }): Promise<Payment> {
  const idk = crypto.randomUUID();
  const res = await fetch(`${API_URL}/payments`, {
    method: "POST",
    headers: { "Content-Type": "application/json", "Idempotency-Key": idk },
    body: JSON.stringify({ payment: input })
  });
  return res.json();
}
