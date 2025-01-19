class NotificationsController < ApplicationController
  DAY_NAMES = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
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
      @days_of_week = @notification.days_of_week.compact.map { |day| DAY_NAMES[day.to_i - 1] }.join(', ')
      render :show
    end
  end
  
  # def create
  #   edited_params = notification_params.to_hash
  #   edited_params["days_of_week"].shift
    
  #   @notification = current_user.build_notification(edited_params)
  #   if @notification.save
  #     redirect_to @notification, notice: 'Schedule was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end


  def create
    edited_params = notification_params.to_hash
    edited_params["days_of_week"].shift

    @notification = current_user.build_notification(edited_params)

    time_zone = params[:notification][:timezone]
    hour = params[:notification][:hour].to_i
    minute = params[:notification][:minute].to_i
    ampm = params[:notification][:ampm]

    hour = 12 if hour == 12
    hour = hour + 12 if ampm == "PM" && hour != 12

    user_time = ActiveSupport::TimeZone[time_zone].local(Time.now.year, Time.now.month, Time.now.day, hour, minute)
    @notification.time = user_time.strftime("%H:%M:%S")

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
    params.require(:notification).permit(:hour, :minute, :ampm, :timezone, days_of_week: [])
  end
end