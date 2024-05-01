class CreateOrderBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :order_budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :final_price
      t.date :valid_until
      t.string :payment_method
      t.decimal :extra_fee
      t.decimal :discount
      t.text :description

      t.timestamps
    end
  end
end
