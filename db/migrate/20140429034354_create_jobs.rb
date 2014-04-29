class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :portfolio, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
