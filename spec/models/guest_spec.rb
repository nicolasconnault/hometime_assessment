require 'rails_helper'

RSpec.describe Guest, type: :model do
  it { should have_many(:guest_phone_numbers).dependent(:destroy) }
  it { should have_many(:reservations) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
end
