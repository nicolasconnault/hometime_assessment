class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :reservation_code, null: false, index: { unique: true }
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.string :status
      t.string :currency
      t.float :total_price
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.references :guest, null: false, foreign_key: true
    
      t.timestamps
    end
  end
end
