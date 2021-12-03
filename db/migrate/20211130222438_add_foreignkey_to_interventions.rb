class AddForeignkeyToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :interventions, :employees, column: :author
  end
end
