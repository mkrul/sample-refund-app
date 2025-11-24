class ChangeReasonToName < ActiveRecord::Migration[7.1]
  def change
    change_column :refund_reasons, :reason, :name
  end
end
