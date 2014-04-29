class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :state
      t.references :user, index: true

      t.timestamps
    end
  end
end
