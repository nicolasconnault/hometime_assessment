class GuestPhoneNumber < ApplicationRecord
  belongs_to :guest

  validates :phone, presence: true, uniqueness: { scope: :guest_id }
end
