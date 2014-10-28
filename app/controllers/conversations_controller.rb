class ConversationsController < ApplicationController
  respond_to :json
  before_action :authenticated?

  def create
    @conversation = Conversation.new(get_params)
    @conversation.save! if @conversation.valid?
    render :json => @conversation
  end

  def update
   @conversation = Conversation.find(get_params[:id])
   @conversation.update!(get_params)
   render :json => @conversation
   
  end

  protected

  def get_params
    params.require(:conversation).permit(:id, :customer_id, :merchant_id, :course_id, :messages_attributes => [:id, :sender_id, :recepient_id, :course_id, :read, :content])
  end


end
