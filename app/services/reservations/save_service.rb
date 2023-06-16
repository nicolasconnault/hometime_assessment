class Reservations::SaveService 
  attr_reader :mapper, :guest, :reservation
 
  def initialize(mapper) 
    @mapper = mapper
    guest
    reservation
    phone_numbers_for_save
    phone_numbers_for_destroy
  end 
 
  def valid? 
    @guest.valid? && 
    @reservation.valid? && 
    @phone_numbers_for_save.all?(&:valid?)
  end
 
  def execute
    @guest.transaction do if valid? && @guest.save && @reservation.save && @phone_numbers_for_save.all?(&:save) && @phone_numbers_for_destroy.map(&:destroy).all?(&:destroyed?)
      return true 
    else 
      raise ActiveRecord::Rollback 
    end 
  end 
end
 
  def errors 
    return {} if !valid? 
    return { 
      guest: guest.errors, 
      reservation: reservation.errors 
    } 
  end
 
  def guest 
    @guest ||= Guest.find_or_initialize_by(email: mapper.guest_email) do |record| 
      record.assign_attributes(mapper.guest_attributes)
    end 
  end
 
  def reservation 
    @reservation ||= Reservation.find_or_initialize_by(reservation_code: mapper.reservation_code) do |record| 
      record.assign_attributes(mapper.reservation_attributes.merge(guest: guest)) 
    end 
  end
 
  def phone_numbers_for_save 
    @phone_numbers_for_save ||= Array(mapper.guest_phone_numbers).map do |number| 
      guest.guest_phone_numbers.find_or_initialize_by(phone: number)
    end
  end
 
  def phone_numbers_for_destroy 
     @phone_numbers_for_destroy ||= guest.guest_phone_numbers.where.not( 
       phone: mapper.guest_phone_numbers 
    ).to_a 
  end 
end