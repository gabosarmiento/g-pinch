class CreatePinches < ActiveRecord::Migration
  def change
    create_table :pinches do |t|
      t.string :note
      t.float :x
      t.float :y
      t.integer :position
      t.references :job, index: true
      t.references :photo, index: true

      t.timestamps
    end
  end
end
