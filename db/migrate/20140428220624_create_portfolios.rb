class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.boolean :public
      t.float :valuation
      t.string :needs

      t.timestamps
    end
  end
end
