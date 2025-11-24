class AddDescriptionToRefundReasons < ActiveRecord::Migration[7.1]
  def change
    add_column :refund_reasons, :description, :string, null: false
  end
end
