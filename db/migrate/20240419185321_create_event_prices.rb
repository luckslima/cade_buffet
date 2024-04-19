class CreateEventPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_prices do |t|
      t.references :event_type, null: false, foreign_key: true
      t.decimal :base_price
      t.decimal :additional_guest_price
      t.decimal :extra_hour_price
      t.boolean :price_for_weekend, default: false

      t.timestamps
    end
  end
end
