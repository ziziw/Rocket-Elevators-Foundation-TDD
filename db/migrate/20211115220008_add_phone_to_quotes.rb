class AddPhoneToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :phone, :string
  end
end
