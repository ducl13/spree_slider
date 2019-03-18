class AddMobileImageToSpreeSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_slides, :mobile_image_file_name, :string
    add_column :spree_slides, :mobile_image_content_type, :string
    add_column :spree_slides, :mobile_image_file_size, :integer
    add_column :spree_slides, :mobile_image_updated_at, :datetime
  end
end
