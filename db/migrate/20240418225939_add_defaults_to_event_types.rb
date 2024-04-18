class AddDefaultsToEventTypes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :event_types, :alcohol_included, from: nil, to: false
    change_column_default :event_types, :decoration_included, from: nil, to: false
    change_column_default :event_types, :parking_available, from: nil, to: false
  end
end
