class CreatePinches < ActiveRecord::Migration
  def change
    create_table :pinches do |t|
      t.text :opinion
      t.string :pinch
      t.integer :position
      t.references :job, index: true
      t.references :photo, index: true

      t.timestamps
    end
  end
end
