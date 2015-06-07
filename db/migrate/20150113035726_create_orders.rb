class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :price
      t.date :completion_date
      t.string :status
      t.string :delivery_type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :telephone
      t.string :email
      t.string :express_token
      t.string :express_payer_id
      t.references :user, index: true
      t.integer :lock_version, default: 0

      t.timestamps
    end
  end
end
