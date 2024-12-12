class DashboardController < ApplicationController
  def index
    if current_user
      render :index
    else # no logged-in user
      redirect_to new_user_registration_path
    end
  end
end
