require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'belongs to an entry' do
    should belong_to(:entry)
  end

  it 'belongs to a user' do
    should belong_to(:user)
  end

  it 'is invalid without a user_id' do
    comment = build(:comment, user_id: nil)
    expect(comment).not_to be_valid
  end

  it 'is invalid without an entry_id' do
    comment = build(:comment, entry_id: nil)
    expect(comment).not_to be_valid
  end
end
