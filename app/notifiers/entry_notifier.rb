# To deliver this notification:
#
# EntryNotifier.with(record: @post, message: "New post").deliver(User.all)

class EntryNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message

  deliver_by :email, mailer: "NotificationMailer"
  deliver_by :custom, class: "FcmDelivery"

  param :message
end
