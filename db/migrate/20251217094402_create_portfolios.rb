class CreatePortfolios < ActiveRecord::Migration[7.2]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.decimal :total_value, precision: 20, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
