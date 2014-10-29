class RenameReceiverAttributeToRecepientOnMessages < ActiveRecord::Migration
  def change
    remove_reference :messages, :receiver
    add_reference :messages, :recepient
  end
end
