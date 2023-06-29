class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :address, null: false
      t.string :post_code, null: false
      t.string :name, null: false
      t.integer :payment, null: false
      t.integer :postage, null: false
      t.integer :total, null: false
      t.integer :status, null: false, default: 0
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
