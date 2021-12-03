class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true

      t.bigint :author
      t.bigint :customer_id
      t.bigint :building_id
      t.bigint :battery_id
      t.bigint :column_id
      t.bigint :elevator_id
      t.bigint :employee_id
      t.datetime :start_intervention
      t.datetime :end_intervention
      t.string :result
      t.string :report
      t.string :status

      t.timestamps
    end
  end
end
