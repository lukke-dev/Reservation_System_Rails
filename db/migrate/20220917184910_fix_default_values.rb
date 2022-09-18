class FixDefaultValues < ActiveRecord::Migration[6.1]
  def change
    change_column :reservations, :booking_status, :integer, default: 0
    change_column :users, :is_admin, :boolean, default: false
    add_column :users, :name, :string, null: false
  end
end
