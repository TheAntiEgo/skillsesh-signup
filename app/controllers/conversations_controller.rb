class ConversationsController < ApplicationController
  before_action :authenticated?
  respond_to :json
  
  def create
    convo_data = get_params[:conversation]
    @convo = Conversation.new do |c|
      c.subject = convo_data[:subject]
      c.merchant = User.find(convo_data[:merchant])
      c.customer = User.find(convo_data[:customer])
      c.body = [convo_data[:body]]
      c.customer_read_at = DateTime.now
    end
    @convo.save!
    render :nothing => true
  end

  def update
    render :nothing => true
  end
  
  def get_params
    params.permit(:conversation => [:subject, :merchant, :customer, :body])
  end    
end
