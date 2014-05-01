class AddPriceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :price_cents, :integer
  end
end
