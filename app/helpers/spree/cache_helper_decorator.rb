Spree::CacheHelper.module_eval do
  
  def cache_key_for_sliders(slides)
    max_updated_at = (slides.except(:group, :order).maximum(:updated_at) || Date.today).to_s(:number)
    sliders_cache_keys = "spree/slides/#{slides.map(&:id).join('-')}-#{max_updated_at}"
    mobile_cache_key = cache_key_for_mobile
    ([sliders_cache_keys] + [mobile_cache_key]).compact.join('/')
  end
  
end