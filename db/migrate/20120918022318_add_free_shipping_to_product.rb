class AddFreeShippingToProduct < ActiveRecord::Migration
  def change
  	add_column :spree_products, :is_free_shipping, :boolean, default: false
  end
end
