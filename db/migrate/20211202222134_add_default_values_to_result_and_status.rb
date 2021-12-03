class AddDefaultValuesToResultAndStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :interventions, :result, "Incomplete"
    change_column_default :interventions, :status, "Pending"
  end
end
