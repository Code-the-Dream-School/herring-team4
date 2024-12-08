require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)  
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid with a duplicate email' do
    create(:user, email: 'user@example.com')
    user = build(:user, email: 'user@example.com')
    expect(user).not_to be_valid
  end

  it 'has many entries' do
    should have_many(:entries)
  end
end
