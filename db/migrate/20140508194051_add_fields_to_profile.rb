class AddFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :country, :string
    add_column :profiles, :website, :string
    add_column :profiles, :header, :string
    add_column :profiles, :pic, :string
    add_column :profiles, :bio, :text
    add_column :profiles, :experience, :text
    add_column :profiles, :title, :string
  end
end
