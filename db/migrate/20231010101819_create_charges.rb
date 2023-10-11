class CreateCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :charges do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.string :transaction_id
      t.string :status

      t.timestamps
    end
  end
end
