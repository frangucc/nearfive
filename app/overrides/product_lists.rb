Deface::Override.new({
  name: 'home_products',
  virtual_path: 'spree/home/index',
  replace: '[data-hook=homepage_products]',
  partial: 'products/list'
})

Deface::Override.new({
  name: 'category_products',
  virtual_path: 'spree/taxons/show',
  replace: '[data-hook=taxon_products]',
  partial: 'products/list'
})