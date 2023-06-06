class Reservation < ApplicationRecord
  belongs_to :guest

  validates :reservation_code, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_comparison_of :end_date, greater_than: :start_date, other_than: Date.today, message: 'must be later than start date'
  validates :nights, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :guests, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :adults, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :children, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :infants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates :currency, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
end
