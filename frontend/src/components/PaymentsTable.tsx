import React from "react";
import { Payment } from "../api";
export default function PaymentsTable({ items }: { items: Payment[] }) {
  return (
    <table style={{ width: "100%", borderCollapse: "collapse" }}>
      <thead>
        <tr>
          <th align="left">Time</th>
          <th align="right">Amount</th>
          <th align="left">Donor</th>
          <th align="left">Email</th>
          <th align="left">Status</th>
        </tr>
      </thead>
      <tbody>
        {items.map((p) => (
          <tr key={p.id}>
            <td>{new Date(p.created_at).toLocaleString()}</td>
            <td align="right">${(p.amount_cents / 100).toFixed(2)} {p.currency}</td>
            <td>{p.name}</td>
            <td>{p.email}</td>
            <td>{p.status}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
