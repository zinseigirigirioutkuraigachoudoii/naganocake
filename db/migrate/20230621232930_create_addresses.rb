class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.references :customer_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
