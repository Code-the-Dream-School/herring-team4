require 'rails_helper'

RSpec.describe "friendships/show.html.erb", type: :view do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user, :username) }
    let!(:friendship) { FactoryBot.create(:friendship, user: user, friend: friend) } 

     

      after(:create) do |user|
       user.profile_picture.attach(
         io: File.open("#{Rails.root}/app/assets/images/default.png"),
         filename: 'default.png',
         content_type: 'image/png'
       )
      end
    

    context "web page text" do
        before do
            assign(:friends, [friendship])
            allow(view).to receive(:current_user).and_return(user)
            render
        end
    end

    it "displays the list of friends" do
        puts friendship.inspect
        puts friend.profile_picture.inspect
        
        expect(friend.profile_picture).to be_attached
        expect(rendered).to include(friendship.friend.username)
        expect(rendered).to have_button("Remove")
    end

    it "shows a message if users has no friends" do
        assign(:friends, [])
        render
        expect(rendered).to have_content("You have no friends added yet.")
    end 

end