class CreatePortfolioItems < ActiveRecord::Migration[7.2]
  def change
    create_table :portfolio_items do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :cryptocurrency, null: false, foreign_key: true
      t.decimal :quantity, precision: 20, scale: 8, null: false
      t.decimal :average_price, precision: 20, scale: 8, null: false

      t.timestamps
      
      t.index [:portfolio_id, :cryptocurrency_id], unique: true
    end
  end
end
