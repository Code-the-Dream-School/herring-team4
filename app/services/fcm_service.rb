class FcmService
  def self.send_notification(device_token, title, body)
    fcm = FCM.new(ENV['FCM_SERVER_KEY'])
    options = { notification: { title: title, body: body } }
    fcm.send([device_token], options)
  end
end