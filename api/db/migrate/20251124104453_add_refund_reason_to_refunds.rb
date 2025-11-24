class AddRefundReasonToRefunds < ActiveRecord::Migration[7.1]
  def up
    add_reference :refunds, :refund_reason, index: true
  end

  def down
    remove_reference :refunds, :refund_reason, index: true
  end
end
