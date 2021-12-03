class AddNullToColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :interventions, :customer_id, :bigint, null: false
    change_column :interventions, :building_id, :bigint, null: false
    change_column :interventions, :battery_id, :bigint, null: false
  end
end
