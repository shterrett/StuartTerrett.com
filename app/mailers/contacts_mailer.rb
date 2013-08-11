class ContactsMailer < ActionMailer::Base
  default from: "website@stuartterrett.com"
  default to: "stuart@stuartterrett.com"
  default subject: "Contact from website"

  def contact_form(contact_form)
    @contact = contact_form
    mail(subject: @contact.subject, reply_to: @contact.email)
  end
 
end
