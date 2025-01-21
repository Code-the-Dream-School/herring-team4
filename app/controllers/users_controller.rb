class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update update_bio]
  before_action :set_user_for_upload, only: [:upload_profile_picture]

  def index
    @users = User.all
  end

  def friend_profile
    @user = User.find(params[:id])
  end

  def show
    @friends = @user.friends
    @entries = @user.entries
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def upload_profile_picture
    if params[:user][:profile_picture].present?
      @user.profile_picture.attach(params[:user][:profile_picture])
      redirect_to @user, notice: 'Profile picture uploaded successfully.'
    else
      redirect_to @user, alert: 'No picture selected.'
    end
  end

  def update_bio
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'Bio updated successfully.'
    else
      render :show
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_user_for_upload
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :bio, :profile_picture)
  end
end
