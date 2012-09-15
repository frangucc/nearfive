Deface::Override.new({
  name: 'container_css_class',
  virtual_path: 'spree/layouts/spree_application',
  set_attributes: 'div.container',
  attributes: { class: 'nf-container' }
})