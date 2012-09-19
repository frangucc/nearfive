Deface::Override.new({
  name: 'info_boxes_in_sidebar',
  virtual_path: 'spree/home/index',
  insert_bottom: '[data-hook=homepage_sidebar_navigation]',
  partial: 'shared/sidebar_info_boxes'
})