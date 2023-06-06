class Guest < ApplicationRecord
  has_many :guest_phone_numbers, dependent: :destroy
  has_many :reservations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
