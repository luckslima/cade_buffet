class AddDetailsToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :details, :string
  end
end
