class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: [:add_friend, :remove_friend]

  def index
    @friends = current_user.friendships
  end

  def search
    @query = params[:query]
    @users = User.search_by_username_or_email(@query) if @query.present?

    friend_ids = current_user.friendships.pluck(:friend_id)
    @users = @users.where.not(id: current_user.id).or(User.where(id: friend_ids))
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
