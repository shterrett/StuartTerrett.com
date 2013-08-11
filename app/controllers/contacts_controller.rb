class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      email = ContactsMailer.contact_form(@contact)
      send_message(email)
    else
      flash.now[:error] = "The contact form is not valid; please complete all fields and check your email address."
      render 'new'
    end
  end
  
  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :body)
  end

  def send_message(email)
    begin
     email.deliver
     flash[:success] = "Thank you for your message!"
     redirect_to root_path
    rescue => err
      logger.warn(err)
      flash.now[:error] = "There was an error delivering your message; please try again. If this error persists, please wait and try later."
      render 'new'
    end
  end

end
