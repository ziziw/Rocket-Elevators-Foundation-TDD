class CreateFactInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.references :employee, foreign_key: true
      t.references :building, foreign_key: true
      t.bigint :battery_id
      t.bigint :column_id
      t.bigint :elevator_id
      t.date :start_intervention
      t.date :end_intervention
      t.string :result
      t.string :report
      t.string :status

      t.timestamps
    end
  end
end
