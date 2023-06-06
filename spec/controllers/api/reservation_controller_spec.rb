require 'rails_helper'

RSpec.describe Api::ReservationController, type: :controller do
  describe "POST #process_payload" do
    let(:payload_schema_1) do
      {
        "reservation_code" => "YYY12345678",
        "start_date" => "2021-04-14",
        "end_date" => "2021-04-18",
        "nights" => 4,
        "guests" => 4,
        "adults" => 2,
        "children" => 2,
        "infants" => 0,
        "status" => "accepted",
        "guest" => {
          "first_name" => "Wayne",
          "last_name" => "Woodbridge",
          "phone" => "639123456789",
          "email" => "wayne_woodbridge@bnb.com"
        },
        "currency" => "AUD",
        "payout_price" => "4200.00",
        "security_price" => "500",
        "total_price" => "4700.00"
      }
    end

    let(:payload_schema_2) do
      {
        "reservation": {
          "code": "XXX12345678",
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": "wayne_woodbridge@bnb.com",
          "guest_first_name": "Wayne",
          "guest_last_name": "Woodbridge",
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
          ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": 4,
          "status_type": "accepted",
          "total_paid_amount_accurate": "4300.00"
        }
      }
    end

    context 'when the payload for schema 1 is valid' do
      it 'returns a success message' do
        post :process_payload, body: payload_schema_1.to_json, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to eq('Payload processed successfully')
      end
    end

    context 'when the payload for schema 2 is valid' do
      it 'returns a success message' do
        post :process_payload, body: payload_schema_2.to_json, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to eq('Payload processed successfully')
      end
    end

    context 'when the payload for schema 1 is invalid' do
      it 'returns an error message' do
        payload_schema_1['guest'].delete('first_name') # Invalidate payload
        post :process_payload, body: payload_schema_1.to_json, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Invalid schema')
      end
    end

    context 'when the JSON is invalid' do
      it 'returns an error message' do
        post :process_payload, body: 'invalid_json', as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Invalid JSON')
      end
    end
  end
end
