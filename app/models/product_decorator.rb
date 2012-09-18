Spree::Product.class_eval do
    attr_accessible :name, :description, :available_on, :permalink, :meta_description,
                    :meta_keywords, :price, :sku, :deleted_at, :prototype_id,
                    :option_values_hash, :on_hand, :weight, :height, :width, :depth,
                    :shipping_category_id, :tax_category_id, :product_properties_attributes,
                    :variants_attributes, :taxon_ids, :option_type_ids, :big_image
  

  def relatives
  	searcher = Spree::Config.searcher_class.new({})
		searcher.retrieve_products.where("spree_products.id <> ?", self.id).limit(4)
  end
  
end