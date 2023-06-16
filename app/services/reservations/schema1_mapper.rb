class Reservations::Schema1Mapper
  attr_reader :payload
 
  def initialize(payload) 
    @payload = payload 
  end

  def guest_attributes
    {
      first_name: payload['guest']['first_name'],
      last_name: payload['guest']['last_name'],
      email: payload['guest']['email']
    }
  end

  def reservation_attributes
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

  def guest_email
    guest_attributes[:email]
  end

  def guest_phone_numbers
    Array.wrap(payload['guest']['phone'])
  end

  def reservation_code
    reservation_attributes[:reservation_code]
  end
end
