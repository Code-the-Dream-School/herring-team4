require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:entry) { FactoryBot.create(:entry) }
  subject { Reaction.new(user: user, entry: entry, emote: "😊") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an entry_id" do
    subject.entry = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_id" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "belongs to an entry" do
    expect(Reaction.reflect_on_association(:entry).macro).to eq(:belongs_to)
  end
end
