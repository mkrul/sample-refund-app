class AddRefunds < ActiveRecord::Migration[7.1]
  def change
    create_table "refunds" do |t|
      t.integer "amount_cents", null: false
      t.string "currency", default: "USD", null: false
      t.string "reason", null: false
      t.references :payment
    end
  end
end
