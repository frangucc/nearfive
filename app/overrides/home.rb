Deface::Override.new({
  name: 'home_products',
  virtual_path: 'spree/home/index',
  replace: '[data-hook=homepage_products]',
  partial: 'home/products'
})