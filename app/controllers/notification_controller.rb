class NotificationsController < ApplicationController
  before_action :set_notification, only: [:edit, :update]

  def new
    @notification = current_user.build_notification
  end

  def edit
  end

  def show
    @notification = current_user.notification || Notification.new(user: current_user)
  end

  def create
    @notification = current_user.build_notification(notification_params)
    if @notification.save
      redirect_to @notification, notice: 'Schedule was successfully created.'
    else
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      redirect_to @notification, notice: 'Schedule was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_notification
    @notification = current_user.notification
  end

  def notification_params
    params.require(:notification).permit(:days_of_week, :time)
  end
end
