class CreateRefundReasons < ActiveRecord::Migration[7.1]
  def change
    create_table :refund_reasons do |t|
      t.string :reason, null: false
      t.timestamps
    end
  end
end
