class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.references :buffet, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :min_guests
      t.integer :max_guests
      t.integer :duration_minutes
      t.text :menu_description
      t.boolean :alcohol_included
      t.boolean :decoration_included
      t.boolean :parking_available
      t.string :location_type

      t.timestamps
    end
  end
end
