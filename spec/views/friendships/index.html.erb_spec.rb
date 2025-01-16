require 'rails_helper'

RSpec.describe "friendships/index.html.erb", type: :view do
    let(:current_user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
   
     before do
       allow(view).to receive(:current_user).and_return(current_user)

       friend.profile_picture.attach(
         io: File.open(Rails.root.join('app/assets/images/default.png')),
         filename: 'default.png',
         content_type: 'image/png'
       )
      end

      context "when there are no users display" do
        it "renders the search form " do
        assign(:users, [])
        render

        expect(rendered).to have_selector("h1", text: "Search for friends:")
        expect(rendered).to have_selector("form")
        expect(rendered).to have_field("query", placeholder: "Enter username or email")
        expect(rendered).to have_button("Search")
      end
    end
      
     context "when users are present" do
      it "displays users with profile picture and remove friend button" do
        assign(:users, [friend])
        current_user.friendships.create(friend_id: friend.id)
        render

        expect(rendered).to have_selector("img[alt='#{friend.username}']")
        expect(rendered).to have_content(friend.username)
        expect(rendered).to have_button("Remove")
      end

      it "displays users with profile picture and add friend button" do
        assign(:users, [friend])
        render

        expect(rendered).to have_selector("img[alt='#{friend.username}']")
        expect(rendered).to have_content(friend.username)
        expect(rendered).to have_button("Add Friend")
      end
    end
end