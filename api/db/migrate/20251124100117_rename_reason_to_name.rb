class RenameReasonToName < ActiveRecord::Migration[7.1]
  def up
    rename_column :refund_reasons, :reason, :name
  end

  def down
    rename_column :refund_reasons, :name, :reason
  end
end
