namespace :refund_reasons do
  desc "Backfill refund_reasons records"
  task backfill_refund_reasons: :environment do
    iterator = 0

    refund_reasons = {
      duplicate_payment: "Customer charged multiple times for same transaction",
      service_not_provided: "Service or product not delivered as expected",
      cancelled_order: "Customer cancelled order before fulfillment",
      defective_product: "Product defective or not as described",
      billing_error: "Incorrect amount charged to customer",
      customer_request: "Customer requested a refund",
      failed_transaction: "Payment processed but service failed",
      policy_violation: "Refund required per policy compliance",
      fraudulent_charge: "Unauthorized or fraudulent transaction",
      other: "Reason not covered by other categories"
    }

    refund_reasons.each do |key, value|
      RefundReason.create(
        name: key,
        description: value
      )
      iterator += 1
    end

    puts "Generated #{iterator} refund reasons"
  end
end
