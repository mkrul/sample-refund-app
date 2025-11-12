import React, { useEffect, useState } from "react";
import ContributionForm from "./components/ContributionForm";
import PaymentsTable from "./components/PaymentsTable";
import { listPayments, Payment } from "./api";
export default function App() {
  const [items, setItems] = useState<Payment[]>([]);
  async function refresh() {
    const res = await listPayments();
    setItems(res);
  }
  useEffect(() => {
    refresh();
    const t = setInterval(refresh, 1500);
    return () => clearInterval(t);
  }, []);
  return (
    <div style={{ display: "grid", gap: 24, padding: 24, fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, Inter, sans-serif" }}>
      <h1>Contributions</h1>
      <ContributionForm onCreated={refresh} />
      <PaymentsTable items={items} />
    </div>
  );
}
