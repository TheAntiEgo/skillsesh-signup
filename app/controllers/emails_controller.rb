class EmailsController < ApplicationController
  def create
    gb = Gibbon::API.new
    gb.lists.subscribe({:id => "2dacf1747b", :email => {:email => params.require(:email)},  :double_optin => false})
    head :ok
  end
end
