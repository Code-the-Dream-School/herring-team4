require 'rails_helper'

RSpec.describe Reaction, type: :model do
  it 'is valid with valid attributes' do
    entry = create(:entry)
    reaction = build(:reaction, entry: entry)  
    expect(reaction).to be_valid
  end

  it 'is invalid without an entry_id' do
    reaction = build(:reaction, entry: nil)
    expect(reaction).not_to be_valid
  end

  it 'belongs to an entry' do
    should belong_to(:entry)
  end
end
