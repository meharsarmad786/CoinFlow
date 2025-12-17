class CreatePriceAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :price_alerts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cryptocurrency, null: false, foreign_key: true
      t.decimal :target_price, precision: 20, scale: 8
      t.string :alert_type, default: 'above'
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
