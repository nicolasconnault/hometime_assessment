class Reservations::Schema1Service < Reservations::PayloadProcessingService
  private

  def guest_params
    {
      first_name: payload['guest']['first_name'],
      last_name: payload['guest']['last_name'],
      phone_numbers: Array.wrap(payload['guest']['phone']), # Ensure this is always an array
      email: payload['guest']['email']
    }
  end

  def reservation_params
    {
      reservation_code: payload['reservation_code'],
      start_date: payload['start_date'],
      end_date: payload['end_date'],
      guests: payload['guests'],
      status: payload['status'],
      total_price: payload['total_price'],
      nights: payload['nights'],
      adults: payload['adults'],
      children: payload['children'],
      infants: payload['infants'],
      currency: payload['currency']
    }
  end
end
