require 'rails_helper'

RSpec.describe Reservations::Schema2Mapper do
  let(:payload) do
    {
      "reservation" => {
        "code" => "XXX12345678",
        "start_date" => "2021-03-12",
        "end_date" => "2021-03-16",
        "expected_payout_amount" => "3800.00",
        "guest_details" => {
          "localized_description" => "4 guests",
          "number_of_adults" => 2,
          "number_of_children" => 2,
          "number_of_infants" => 0
        },
        "guest_email" => "wayne_woodbridge@bnb.com",
        "guest_first_name" => "Wayne",
        "guest_last_name" => "Woodbridge",
        "guest_phone_numbers" => [
          "639123456789",
          "639123456780"
        ],
        "listing_security_price_accurate" => "500.00",
        "host_currency" => "AUD",
        "nights" => 4,
        "number_of_guests" => 4,
        "status_type" => "accepted",
        "total_paid_amount_accurate" => "4300.00"
      }
    }
  end

  let(:guest_attributes) do
    { first_name: 'Wayne', last_name: 'Woodbridge', email: 'wayne_woodbridge@bnb.com' }
  end

  let(:reservation_attributes) do
    {
      reservation_code: 'XXX12345678',
      start_date: '2021-03-12',
      end_date: '2021-03-16',
      guests: 4,
      status: 'accepted',
      total_price: '4300.00',
      nights: 4,
      adults: 2,
      children: 2,
      infants: 0,
      currency: 'AUD'
    }
  end

  subject { described_class.new(payload) }

  describe '#guest_attributes' do
    it 'returns correct guest attributes' do
      expect(subject.guest_attributes).to eq guest_attributes
    end
  end

  describe '#reservation_attributes' do
    it 'returns correct reservation attributes' do
      expect(subject.reservation_attributes).to eq reservation_attributes
    end
  end

  describe '#guest_email' do
    it 'returns correct guest email' do
      expect(subject.guest_email).to eq guest_attributes[:email]
    end
  end

  describe '#guest_phone_numbers' do
    it 'returns correct guest phone numbers' do
      expect(subject.guest_phone_numbers).to eq payload['reservation']['guest_phone_numbers']
    end
  end

  describe '#reservation_code' do
    it 'returns correct reservation code' do
      expect(subject.reservation_code).to eq reservation_attributes[:reservation_code]
    end
  end
end
