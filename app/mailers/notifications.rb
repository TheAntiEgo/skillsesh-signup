class Notifications < ActionMailer::Base
  default :from => "SkillSesh <notifications@skillsesh.com>", :reply_to => 'do-not-reply@skillsesh.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.confirmation.subject
  #
  def confirmation
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_message.subject
  #
  def new_message(msg)
    @sender = msg.sender
    @recepient = msg.recepient
    @snippet = msg.content.first(100)
    
    mail :to => @recepient.email, :subject => "You have a new message from #{@sender.first_name}!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.reminder.subject
  #
  def reminder
  end
end
