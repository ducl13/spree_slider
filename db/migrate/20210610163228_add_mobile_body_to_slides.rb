class AddMobileBodyToSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_slides, :mobile_body, :string
  end
end
