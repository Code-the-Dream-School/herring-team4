require 'rails_helper'

RSpec.describe "friendships/show.html.erb", type: :view do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
    let!(:friendship) { FactoryBot.create(:friendship, user: user, friend: friend) } 

    before do
       friend.profile_picture.attach(
         io: File.open(Rails.root.join('app/assets/images/default.png')),
         filename: 'default.png',
         content_type: 'image/png'
       )
      end

    context "when there are friends" do
        before do
            assign(:friends, [friendship])
            allow(view).to receive(:current_user).and_return(user)
            render
        end
    
    it "displays the list of friends" do
        expect(rendered).to include(friendship.friend.username)
        expect(rendered).to have_selector("img[alt='#{friend.username}']")
        expect(rendered).to have_button("Remove")
    end
end

    it "shows a message if users has no friends" do
        assign(:friends, [])
        render
        expect(rendered).to have_content("You have no friends added yet.")
    end 

end