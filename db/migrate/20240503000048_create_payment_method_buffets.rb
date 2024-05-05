class CreatePaymentMethodBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_method_buffets do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
