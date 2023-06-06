class CreateGuestPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_phone_numbers do |t|
      t.string :phone, null: false
      t.references :guest, null: false, foreign_key: true
    
      t.timestamps
    end
  end
end
