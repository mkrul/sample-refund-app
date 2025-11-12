class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.integer :amount_cents, null: false
      t.string :currency, null: false, default: "USD"
      t.string :email, null: false
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.string :idempotency_key, null: false
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
    add_index :payments, :idempotency_key, unique: true
    add_index :payments, :status
    add_index :payments, :created_at
  end
end
