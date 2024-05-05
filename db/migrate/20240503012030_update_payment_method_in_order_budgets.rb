class UpdatePaymentMethodInOrderBudgets < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_budgets, :payment_method, :string
    add_reference :order_budgets, :payment_method, null: false, foreign_key: true
  end
end
