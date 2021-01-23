class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :start
      t.integer :end
      t.integer :total_price
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
