class AddBigImageToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :big_image, :boolean, :default => false
  end
end
