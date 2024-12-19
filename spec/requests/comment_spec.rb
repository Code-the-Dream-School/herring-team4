require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/comment/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /view" do
    it "returns http success" do
      get "/comment/view"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/comment/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/comment/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
