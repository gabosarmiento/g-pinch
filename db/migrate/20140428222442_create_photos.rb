class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :image
      t.references :portfolio, index: true
      t.integer :position
      t.boolean :adult
      t.string :exif
      t.string :category

      t.timestamps
    end
  end
end
