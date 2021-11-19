class AddFullNameToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :full_name, :string
  end
end
