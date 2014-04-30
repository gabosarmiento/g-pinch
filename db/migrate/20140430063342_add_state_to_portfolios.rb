class AddStateToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :state, :string
  end
end
