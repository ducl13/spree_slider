class Spree::Slide < ActiveRecord::Base
  has_and_belongs_to_many :slide_locations,
                          class_name: 'Spree::SlideLocation',
                          join_table: 'spree_slide_slide_locations'

  belongs_to :product, touch: true, optional: true

  has_one_attached :image
  has_one_attached :mobile_image

  validates :link_url, presence: true, url: true, unless: -> { product }
  validates :name, :image, :mobile_image, presence: true, unless: -> { product }
  validates :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates :mobile_image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  scope :published, -> { where(published: true).order('position ASC') }
  scope :location, ->(location) { joins(:slide_locations).where('spree_slide_locations.name = ?', location) }
  scope :product_slides, -> { published.where.not(product_id: nil).order('position ASC') }
  scope :image_slides, -> { published.where(product_id: nil).order('position ASC') }

  STYLES = {
    preview: '120x120',
    thumbnail: '240x240'
  }.freeze

  def initialize(attrs = nil)
    attrs ||= { published: true }
    super
  end

  def slide_name
    name.blank? && product.present? ? product.name : name
  end

  def slide_mobile_name
    mobile_name.present? ? mobile_name : slide_name
  end

  def slide_mobile_body
    mobile_body.present? ? mobile_body : body
  end

  def slide_link
    link_url.blank? && product.present? ? product : link_url
  end

  def slide_image
    !image.attached? && product.present? && product.images.any? ? product.images.first.attachment : image.attachment
  end

  def slide_mobile_image
    !mobile_image.attached? && product.present? && product.images.any? ? product.images.first.attachment : mobile_image.attachment
  end

  # Helper for resizing
  def preview
    image_form(:preview)
  end

  def mobile_preview
    mobile_image_form(:preview)
  end

  def thumbnail
    image_form(:thumbnail)
  end

  def mobile_thumbnail
    mobile_image_form(:thumbnail)
  end

  private

  def image_form(form)
    slide_image.variant(resize: STYLES[form])
  end

  def mobile_image_form(form)
    slide_mobile_image.variant(resize: STYLES[form])
  end
end
