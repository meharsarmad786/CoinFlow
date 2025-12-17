class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :cryptocurrency, null: false, foreign_key: true, index: true
      t.string :transaction_type, null: false
      t.decimal :quantity, precision: 20, scale: 8, null: false
      t.decimal :price, precision: 20, scale: 8, null: false
      t.decimal :total_amount, precision: 20, scale: 8, null: false

      t.timestamps
      
      t.index [:user_id, :created_at]
    end
  end
end
