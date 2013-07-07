class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    # send email 
    render 'new'
  end
  
  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :body)
  end
  
end
