require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:notification) { build(:notification, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(notification).to be_valid
    end

    # it 'is invalid without days_of_week' do
    #   notification.days_of_week = nil
    #   expect(notification).to_not be_valid
    # end

    it 'is invalid without an hour' do
      notification.hour = nil
      expect(notification).to_not be_valid
    end

    it 'is invalid without a minute' do
      notification.minute = nil
      expect(notification).to_not be_valid
    end

    it 'is invalid without ampm' do
      notification.ampm = nil
      expect(notification).to_not be_valid
    end
  end

  describe 'days_of_week' do
    # it 'stores the days_of_week as a comma-separated string and retrieves it as an array' do
    #   notification.days_of_week = ["Monday", "Tuesday", "Wednesday"]
    #   notification.save
    #   expect(notification.reload.days_of_week).to eq(["Monday", "Tuesday", "Wednesday"])
    # end

    # it 'returns the days_of_week as an array' do
    #   notification.days_of_week = ["Monday", "Tuesday", "Wednesday"]
    #   notification.save
    #   expect(notification.days_of_week).to eq(["Monday", "Tuesday", "Wednesday"])
    # end
  end
end
