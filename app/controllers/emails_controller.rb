class EmailsController < ApplicationController
  def create
    gb = Gibbon::API.new
    gb.lists.subscribe({:id => "2dacf1747b", :email => {:email => get_params[:email]},  :double_optin => false})
  end
  
  def get_params
    params.require(:email)
  end
end
