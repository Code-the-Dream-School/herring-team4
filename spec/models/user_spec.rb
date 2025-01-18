require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      duplicate_user = build(:user, email: user.email)
      expect(duplicate_user).to_not be_valid
    end

    it "is not valid without a username" do
      user.username = nil
      expect(user).to_not be_valid
    end
  end

  describe "associations" do
    it "has many entries" do
      expect(User.reflect_on_association(:entries).macro).to eq(:has_many)
    end

    it "allows attaching a profile picture" do
      user.profile_picture.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'default.png')),
        filename: 'default.png',
        content_type: 'image/png'
      )
      expect(user.profile_picture).to be_attached
    end
  end

  describe "streak calculation" do
    let!(:user) { create(:user) }

    it "returns 0 when the user has no entries" do
      expect(user.calculate_streak).to eq(0)
    end

    it "returns 1 if the user only has today's entry" do
      create(:entry, user: user, created_at: Date.current)
      expect(user.calculate_streak).to eq(1)
    end

    it "stops counting when there is a gap in the streak" do
      create(:entry, user: user, created_at: Date.current)
      create(:entry, user: user, created_at: Date.current - 1)
      create(:entry, user: user, created_at: Date.current - 2)
      create(:entry, user: user, created_at: Date.current - 4)
      create(:entry, user: user, created_at: Date.current - 5)
      expect(user.calculate_streak).to eq(3)
    end

    it "keeps counting when there is no gap in the streak" do
      create(:entry, user: user, created_at: Date.current)
      create(:entry, user: user, created_at: Date.current - 1)
      create(:entry, user: user, created_at: Date.current - 2)
      expect(user.calculate_streak).to eq(3)
    end

    it "ignores multiple entries on the same day" do
      create(:entry, user: user, created_at: Date.current)
      create(:entry, user: user, created_at: Date.current)
      expect(user.calculate_streak).to eq(1)
    end
  end
end
