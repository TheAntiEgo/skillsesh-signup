# Preview all emails at http://localhost:3000/rails/mailers/notifications
class NotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications/confirmation
  def confirmation
    Notifications.confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/new_message
  def new_message
    Notifications.new_message
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/reminder
  def reminder
    Notifications.reminder
  end

end
