class FcmDelivery < Noticed::DeliveryMethods::Base
  def deliver
    FcmService.send_notification(recipient.device_token, "Notification", params[:message])
  end
end