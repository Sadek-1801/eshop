class AddPayTypeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :account_number, :integer, optional: true
    add_column :orders, :routing_number, :integer, optional: true
    add_column :orders, :credit_card_number, :integer, optional: true
    add_column :orders, :expiration_date, :string, optional: true
    add_column :orders, :po_number, :integer, optional: true
  end
end
