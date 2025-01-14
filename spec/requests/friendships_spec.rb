require 'rails_helper'

RSpec.describe "Friendships", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end