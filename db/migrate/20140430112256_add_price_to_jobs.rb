class AddPriceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :price, :float
  end
end
