require 'rails_helper'

RSpec.describe Reservations::Schema1Mapper do
  let(:payload) do
    {
      "guest" => {
        "first_name" => "John",
        "last_name" => "Doe",
        "phone" => ["1234567890"],
        "email" => "john.doe@example.com"
      },
      "reservation_code" => "XXX",
      "start_date" => "2021-01-01",
      "end_date" => "2021-01-02",
      "guests" => 1,
      "status" => "accepted",
      "total_price" => "100.0",
      "nights" => 1,
      "adults" => 1,
      "children" => 0,
      "infants" => 0,
      "currency" => "USD"
    }
  end

  let(:guest_attributes) do
    { first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com' }
  end

  let(:reservation_attributes) do
    {
      reservation_code: 'XXX',
      start_date: '2021-01-01',
      end_date: '2021-01-02',
      guests: 1,
      status: 'accepted',
      total_price: '100.0',
      nights: 1,
      adults: 1,
      children: 0,
      infants: 0,
      currency: 'USD'
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
      expect(subject.guest_phone_numbers).to eq payload['guest']['phone']
    end
  end

  describe '#reservation_code' do
    it 'returns correct reservation code' do
      expect(subject.reservation_code).to eq reservation_attributes[:reservation_code]
    end
  end
end
