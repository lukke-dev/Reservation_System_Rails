class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :booking_date
      t.datetime :return_date
      t.integer :booking_status

      t.timestamps
    end
  end
end
