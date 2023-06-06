class Reservations::PayloadProcessingService
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def process_payload
    ActiveRecord::Base.transaction do
      guest = find_or_create_guest(guest_params)
      reservation_params_with_guest = reservation_params.merge(guest: guest)
      reservation = find_or_create_reservation(reservation_params_with_guest)
      return false unless reservation
      reservation.update!(reservation_params_with_guest)
    end
  
    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to process payload: #{e.message}")
    false
  end

  private

  def guest_params
    raise NotImplementedError, 'You must implement guest_params.'
  end

  def reservation_params
    raise NotImplementedError, 'You must implement reservation_params.'
  end

  def find_or_create_guest(params)
    Guest.find_or_create_by!(email: params[:email]) do |guest|
      guest.first_name = params[:first_name]
      guest.last_name = params[:last_name]
    end.tap do |guest|
      update_guest_phone_numbers(guest, params[:phone_numbers]) unless params[:phone_numbers].blank?
    end
  end

  def find_or_create_reservation(params)
    reservation = Reservation.find_or_initialize_by(reservation_code: params[:reservation_code])

    if reservation.new_record?
      reservation.guest = params[:guest]
      reservation.attributes = params
      unless reservation.save
        Rails.logger.error("Failed to create reservation: #{reservation.errors.full_messages.join(', ')}")
        return false
      end
    end
    reservation
  end

  # We assume that new reservations contain the most accurate phone numbers, so we delete old ones
  def update_guest_phone_numbers(guest, phone_numbers)
    guest.guest_phone_numbers.where.not(phone: phone_numbers).destroy_all
    phone_numbers.each do |phone|
      guest.guest_phone_numbers.find_or_create_by!(phone: phone)
    end
  end
end
