class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: [:add_friend, :remove_friend]

  def index
    @friends = current_user.friendships
  end

  def add_friend
    if current_user.add_friend(@friend)
      flash[:notice] = "#{@friend.email} has been added as a friend!"
    else
      flash[:alert] = "Unable to add friend."
    end
    redirect_to friendships_path(@user)
  end

  def remove_friend
    if current_user.remove_friend(@friend)
      flash[:notice] = "#{@friend.email} has been removed from your friends"
    else
      flash[:alert] = "Unable to remove friend"
    end
    redirect_to friendships_path(@user)
  end

  private

  def set_friend
    @friend = User.find_by(email: params[:email])
    if @friend.nil?
      flash[:alert] = "User not found"
      redirect_to friendships_path
    end
  end

end
