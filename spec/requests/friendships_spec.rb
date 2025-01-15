require 'rails_helper'

RSpec.describe "Friendships", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
    let!(:friendship) { FactoryBot.create(:friendship, user: user, friend: friend) }

    before do 
        sign_in user
    end
    
   describe "GET #index" do
    it "assigns the user's friendships to @friends" do
        get friendships_path
        expect(assigns(:friends)).to eq([friendship])
    end

    it "assigns an empty  array to @users" do
        get friendships_path
        expect(assigns(:users)).to eq([])
    end
  end 

   describe "GET #show" do
    it "assings the user's friendships to @friends" do
        get friendship_path(friendship)
        expect(assigns(:friends)).to eq([friendship])
  end
end

    describe "GET #search" do
      context "when query is present" do
        it "assigns the matching users to @users" do
            get search_friendships_path, params: { query: friend.username }
            expect(assigns(:users)).to include(friend)
            expect(assigns(:users)).not_to include(user)
        end
    end 

    context "when query is empty" do
        it "assigns all users except the current user to @users" do
            get search_friendships_path, params: { query: "" }
            expect(assigns(:users)).to match_array([friend])
        end
    end
end

    describe "POST #add_friend" do
      context "when user is found" do
        it "adds the user as a friend and displays a success message" do
            post add_friend_friendships_path, params: { username: friend.username }
            expect(flash[:notice]).to eq("#{friend.username} has been added as a friend!")
            expect(response).to redirect_to(friendships_path)
        end
    end

    context "when the friend cannot be added" do
        before do
            allow(user).to receive(:add_friend).and_return(false)
        end
        
        it "redirects to friendships path with an error message" do
            post add_friend_friendships_path, params: { username: friend.username }
            expect(flash[:alert]).to eq("Unable to add friend.")
            expect(response).to redirect_to(friendships_path)
        end
    end



    describe "DELETE #remove_friend" do
      context "when user is found" do
        it "removes friend and displays a success message" do
            delete remove_friend_friendships_path, params: { username: friend.username }
            expect(flash[:notice]).to eq("#{friend.username} has been removed from your friends")
            expect(response).to redirect_to(friendships_path)
        end
    end

    context "when the friend cannot be added" do
        before do
            allow(user).to receive(:remove_friend).and_return(false)
        end
        
        it "redirects to friendships path with an error message" do
            delete remove_friend_friendships_path, params: { username: friend.username }
            expect(flash[:alert]).to eq("Unable to remove friend")
            expect(response).to redirect_to(friendships_path)
        end
    end
end
end
end