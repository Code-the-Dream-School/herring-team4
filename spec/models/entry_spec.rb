require 'rails_helper'

RSpec.describe Entry, type: :model do
  subject { Entry.new(user: create(:user)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user_id" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "belongs to a user" do
    expect(Entry.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "has many reactions" do
    expect(Entry.reflect_on_association(:reactions).macro).to eq(:has_many)
  end
end
