import React, { useState } from "react";
import { createPayment } from "../api";
export default function ContributionForm({ onCreated }: { onCreated: () => void }) {
  const [amount, setAmount] = useState(10);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [busy, setBusy] = useState(false);
  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    await createPayment({ amount_cents: Math.round(amount * 100), currency: "USD", name, email });
    setBusy(false);
    onCreated();
  }
  return (
    <form onSubmit={submit} style={{ display: "grid", gap: 12, maxWidth: 420 }}>
      <label>
        Amount (USD)
        <input type="number" min={1} step={1} value={amount} onChange={(e) => setAmount(Number(e.target.value))} />
      </label>
      <label>
        Name
        <input value={name} onChange={(e) => setName(e.target.value)} />
      </label>
      <label>
        Email
        <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      </label>
      <button disabled={busy}>{busy ? "Submitting..." : "Contribute"}</button>
    </form>
  );
}
