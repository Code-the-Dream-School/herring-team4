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

RSpec.describe User, type: :model do
  describe "calculating a streak" do
    subject { User.create(email: "user@example.com", password: "password") }

    it "returns 0 when the user has no entries" do
      result = subject.calculate_streak
      expect(result).to eq(0)
    end

    it "returns 0 when the user has no consecutive entries in relation to today" do

    end

    it "returns 1 if the user only has today's entry" do
      create(:entry, user: subject, created_at: Date.current)
      result = subject.calculate_streak
      expect(result).to eq(1)
    end

    it "stops counting when there is a gap in the streak" do
      create(:entry, user: subject, created_at: Date.current)
      create(:entry, user: subject, created_at: Date.current - 1)
      create(:entry, user: subject, created_at: Date.current - 2)
      create(:entry, user: subject, created_at: Date.current - 4)
      create(:entry, user: subject, created_at: Date.current - 5)
      result = subject.calculate_streak
      expect(result).to eq(3)
    end

    it "keeps counting when there is no gap in the streak" do
      create(:entry, user: subject, created_at: Date.current)
      create(:entry, user: subject, created_at: Date.current - 1)
      create(:entry, user: subject, created_at: Date.current - 2)
      result = subject.calculate_streak
      expect(result).to eq(3)
    end

    it "ignores multiple entries on the same day" do
      create(:entry, user: subject, created_at: Date.current)
      create(:entry, user: subject, created_at: Date.current)
      result = subject.calculate_streak
      expect(result).to eq(1)
    end

  end
end
