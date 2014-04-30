class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :job, index: true
      t.string :email
      t.string :guid

      t.timestamps
    end
  end
end
