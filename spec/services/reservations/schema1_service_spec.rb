require 'rails_helper'

RSpec.describe Reservations::Schema1Service do
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

  subject { described_class.new(payload) }

  describe '#process_payload' do
    it 'creates a new guest and reservation' do
      expect { subject.process_payload }.to change { Guest.count }.by(1)
        .and change { Reservation.count }.by(1)
        .and change { GuestPhoneNumber.count }.by(1)
    end

    context 'when guest already exists' do
      let!(:existing_guest) { create(:guest, email: payload['guest']['email']) }

      it 'does not create a new guest' do
        expect { subject.process_payload }.not_to change { Guest.count }
      end
    end

    context 'when reservation already exists' do
      let!(:existing_guest) { create(:guest, email: payload['guest']['email']) }
      let!(:existing_reservation) { create(:reservation, guest: existing_guest, reservation_code: payload['reservation_code']) }

      it 'does not create a new reservation' do
        expect { subject.process_payload }.not_to change { Reservation.count }
      end
    end
  end
end
