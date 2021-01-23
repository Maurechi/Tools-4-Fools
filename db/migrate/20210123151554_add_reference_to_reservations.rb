class AddReferenceToReservations < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :tools, null: false, foreign_key: true
  end
end
