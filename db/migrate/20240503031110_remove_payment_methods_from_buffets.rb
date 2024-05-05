class RemovePaymentMethodsFromBuffets < ActiveRecord::Migration[7.1]
  def change
    remove_column :buffets, :payment_methods, :string  
  end
end
