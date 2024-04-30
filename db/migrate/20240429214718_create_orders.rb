class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.integer :number_of_guests
      t.date :event_date
      t.string :address
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
