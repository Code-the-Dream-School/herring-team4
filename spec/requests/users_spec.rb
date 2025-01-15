require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, bio: nil, profile_picture: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/default.png'), 'image/png')) }
  
  let(:valid_attributes) do
    {
      bio: Faker::Lorem.sentence,
      profile_picture: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/default.png'), 'image/png')
    }
  end
  
  let(:invalid_attributes) do
    {
      bio: nil,
      profile_picture: nil
    }
  end

  describe "GET /edit" do
    it "returns a successful response" do
      sign_in user
      get edit_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the user's bio and profile picture" do
        sign_in user
        valid_bio = valid_attributes[:bio]
        patch update_bio_user_path(user), params: { user: { bio: valid_bio } }
        user.reload
        expect(user.bio).to eq(valid_bio)
        expect(user.profile_picture).to be_attached
      end
    end

    context "with invalid parameters" do
      it "does not update the user and re-renders the edit template" do
        sign_in user
        patch user_registration_path, params: { user: invalid_attributes }
        user.reload
        expect(user.bio).to be_nil  
        expect(user.profile_picture.filename).to eq('default.png') 
        expect(response.body).to include('error')
      end
    end
  end
end
