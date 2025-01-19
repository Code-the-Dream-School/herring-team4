# class SendScheduledNotificationsJob < ApplicationJob
#   queue_as :default

#   def perform
#     now = Time.current.in_time_zone("UTC")

#     User.joins(:notification).where("? = ANY(notification.days_of_week)", now.wday).find_each do |user|
#       notification_time = user.notification.time.in_time_zone(user.notification.timezone)

#       if notification_time.hour == now.hour && notification_time.min == now.min
#         user.notifications.create!(type: ScheduleNotification, params: { message: "It's time to journal" })
#       end
#     end
#   end
# end

class SendScheduledNotificationsJob < ApplicationJob
  queue_as :default

  def perform
    # Hardcoded time for testing (e.g., 12:00 PM UTC)
    now = Time.current.in_time_zone("EST")  # Get current time in EST
    hardcoded_time = Time.new(now.year, now.month, now.day, 18, 41, 0, "-05:00")  # 6:41 PM EST

    # Hardcoded email for testing
    hardcoded_email = "jacinthadev8@gmail.com"

    # Simulate user notification for testing purposes
    user = User.find_by(email: hardcoded_email)
    
    if user.present?
      # Check if it's time to send a notification (i.e., if current time matches hardcoded time)
      if now.hour == hardcoded_time.hour && now.min == hardcoded_time.min
        # Send the notification
        EntryNotifier.with(message: "Test notification").deliver(user)
      end
    else
      puts "User with email #{hardcoded_email} not found!"
    end
  end
end
