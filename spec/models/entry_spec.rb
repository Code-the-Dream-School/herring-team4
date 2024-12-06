require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'is valid with valid attributes' do
    user = create(:user)
    entry = build(:entry, user: user)  
    expect(entry).to be_valid
  end

  it 'is invalid without a user_id' do
    entry = build(:entry, user: nil)
    expect(entry).not_to be_valid
  end

  it 'belongs to a user' do
    should belong_to(:user)
  end

  it 'has many reactions' do
    should have_many(:reactions)
  end
end
