class CreateCryptocurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :cryptocurrencies do |t|
      t.string :symbol, null: false
      t.string :name, null: false
      t.decimal :current_price, precision: 20, scale: 8, null: false
      t.decimal :market_cap, precision: 20, scale: 2
      t.decimal :volume_24h, precision: 20, scale: 2
      t.decimal :price_change_24h, precision: 20, scale: 8
      t.decimal :price_change_percentage_24h, precision: 10, scale: 2

      t.timestamps
      
      t.index :symbol, unique: true
      t.index :market_cap
    end
  end
end
