require 'rails_helper'

RSpec.describe Reservations::Schema2Service do
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
  
  subject { described_class.new(payload) }

  describe '#process_payload' do
    it 'creates a new guest and reservation' do
      expect { subject.process_payload }.to change { Guest.count }.by(1)
        .and change { Reservation.count }.by(1)
        .and change { GuestPhoneNumber.count }.by(2)
    end

    context 'when guest already exists' do
      let!(:existing_guest) { create(:guest, email: payload['reservation']['guest_email']) }

      it 'does not create a new guest' do
        expect { subject.process_payload }.not_to change { Guest.count }
      end
    end

    context 'when reservation already exists' do
      let!(:existing_guest) { create(:guest, email: payload['reservation']['guest_email']) }
      let!(:existing_reservation) { create(:reservation, guest: existing_guest, reservation_code: payload['reservation']['code']) }

      it 'does not create a new reservation' do
        expect { subject.process_payload }.not_to change { Reservation.count }
      end
    end
  end
end
