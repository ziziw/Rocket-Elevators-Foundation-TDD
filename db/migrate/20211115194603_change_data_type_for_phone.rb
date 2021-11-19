class ChangeDataTypeForPhone < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :phone, :string
  end
end
