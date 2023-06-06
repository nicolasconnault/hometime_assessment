require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to(:guest) }

  it { should validate_presence_of(:reservation_code) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:nights) }
  it { should validate_presence_of(:guests) }
  it { should validate_presence_of(:adults) }
  it { should validate_presence_of(:children) }
  it { should validate_presence_of(:infants) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:currency) }
  it { should validate_presence_of(:total_price) }

  describe 'date validations' do
    it 'does not allow end_date to be earlier than start_date' do
      subject.start_date = Date.today
      subject.end_date = Date.yesterday
      expect(subject).not_to be_valid
      expect(subject.errors[:end_date]).to include('must be later than start date')
    end
  end
end
