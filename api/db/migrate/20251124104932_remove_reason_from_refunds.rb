class RemoveReasonFromRefunds < ActiveRecord::Migration[7.1]
  def up
    remove_column :refunds, :reason
  end

  def down
    add_column :refunds, :reason, null: false
  end
end
