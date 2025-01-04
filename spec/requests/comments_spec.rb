require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:friend) { FactoryBot.create(:user, username: "friend_1") }
  let(:entry) {FactoryBot.create(:entry, user: friend) }
  let(:comment) { FactoryBot.create(:comment, entry: entry, user: user) }

  before do 
    FactoryBot.create(:friendship, user: user, friend: friend)
    FactoryBot.create(:friendship, user: friend, friend: user)
    sign_in user
  end

  describe "GET /entries/:entry_id/comments" do
    it "assigns comments to @comments" do
      get "/entries/#{entry.id}/comments"
     expect(response).to have_http_status(:success)
    end

    it "responds successfully with an HTTP 200 status" do
      get "/entries/#{entry.id}/comments"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /entries/:entry_id/comments/:id" do
    it "returns http success" do
      get "/entries/#{entry.id}/comments/#{comment.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /entries/:entry_id/comments/new" do
    it "returns http success" do
      get "/entries/#{entry.id}/comments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /entries/entry_id/comments/:id/edit" do
    it "returns http success" do
      get "/entries/#{entry.id}/comments/#{comment.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
