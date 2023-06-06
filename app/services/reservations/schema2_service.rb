class Reservations::Schema2Service < Reservations::PayloadProcessingService
  private

  def guest_params
    {
      first_name: payload['reservation']['guest_first_name'],
      last_name: payload['reservation']['guest_last_name'],
      phone_numbers: Array.wrap(payload['reservation']['guest_phone_numbers']), # Ensure this is always an array
      email: payload['reservation']['guest_email']
    }
  end

  def reservation_params
    {
      reservation_code: payload['reservation']['code'],
      start_date: payload['reservation']['start_date'],
      end_date: payload['reservation']['end_date'],
      guests: payload['reservation']['number_of_guests'],
      status: payload['reservation']['status_type'],
      total_price: payload['reservation']['total_paid_amount_accurate'],
      nights: payload['reservation']['nights'],
      adults: payload['reservation']['guest_details']['number_of_adults'],
      children: payload['reservation']['guest_details']['number_of_children'],
      infants: payload['reservation']['guest_details']['number_of_infants'],
      currency: payload['reservation']['host_currency']
    }
  end
end
