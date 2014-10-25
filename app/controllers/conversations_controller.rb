class ConversationsController < ApplicationController
  respond_to :json
  before_action :authenticated?

  def create
    convo = Conversation.new get_params
    convo.save! if convo.valid?
    render :nothing => true
  end

  def update
    convo = Conversation.find get_params
    convo.update! get_params
    render :nothing => true
  end

  protected

  def get_params
    params.require(:conversation).permit :customer, :merchant, :course, :message => [:sender, :receiver, :course, :read, :content]
  end


end
