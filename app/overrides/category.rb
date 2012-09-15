Deface::Override.new({
  name: 'category_sidebar',
  virtual_path: 'spree/taxons/show',
  replace: "[data-hook=taxon_sidebar_navigation]",
  partial: 'spree/shared/taxonomies'
})