class NotificationsController < ApplicationController
  before_action :set_notification, only: [:edit, :update, :show]

  def new
    @notification = current_user.build_notification
  end

  def edit
  end

  def show
    if @notification.new_record?
      render :new
    else
      render :show
    end
  end

  def create
    @notification = current_user.build_notification(notification_params)
    if @notification.save
      redirect_to @notification, notice: 'Schedule was successfully created.'
    else
      render :new, status: :unprocessable_entity
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
    @notification = current_user.notification || current_user.build_notification
  end

  def notification_params
    params.require(:notification).permit(:hour, :minute, :ampm, days_of_week: [])
  end  
end
