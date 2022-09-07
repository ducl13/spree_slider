Spree::FrontendHelper.class_eval do
  
  def cache_key_for_sliders(slides)
    max_updated_at = (slides.except(:group, :order).maximum(:updated_at) || Date.today).to_s(:number)
    "spree/slides/#{slides.map(&:id).join('-')}-#{max_updated_at}"
  end
  
end