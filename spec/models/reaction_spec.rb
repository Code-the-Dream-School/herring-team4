require 'rails_helper'

RSpec.describe Reaction, type: :model do
  subject { Reaction.new(entry: create(:entry)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an entry_id" do
    subject.entry = nil
    expect(subject).to_not be_valid
  end

  it "belongs to an entry" do
    expect(Reaction.reflect_on_association(:entry).macro).to eq(:belongs_to)
  end
end
