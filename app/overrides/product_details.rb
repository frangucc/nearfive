Deface::Override.new({
  name: 'product_details',
  virtual_path: 'spree/products/show',
  replace: '[data-hook=product_show]',
  partial: 'products/show'
})