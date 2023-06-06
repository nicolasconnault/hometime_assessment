require 'rails_helper'

RSpec.describe GuestPhoneNumber, type: :model do
  it { should belong_to(:guest) }
  
  it { should validate_presence_of(:phone) }
end
