Deface::Override.new({
  name: 'breadcrumb_remove',
  virtual_path: 'spree/layouts/spree_application',
  remove: "code[erb-loud]:contains('breadcrumbs(@taxon)')"
})