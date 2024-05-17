class AddMobileNameToSpreeSlides < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_slides, :mobile_name, :string
  end
end
