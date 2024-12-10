require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(user: create(:user), entry: create(:entry)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user_id" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an entry_id" do
    subject.entry = nil
    expect(subject).to_not be_valid
  end

  it "belongs to an entry" do
    expect(Comment.reflect_on_association(:entry).macro).to eq(:belongs_to)
  end

  it "belongs to a user" do
    expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
  end
end
