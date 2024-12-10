require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(email: "user@example.com", password: "password") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate email" do
    subject2 = User.create(email: subject.email, password: "password")
    expect(subject2).to_not be_valid
  end

  it "has many entries" do
    expect(User.reflect_on_association(:entries).macro).to eq(:has_many)
  end
end
