class MailPreview < MailView
  contact_form = Contact.new(name: 'Houdini', email: 'houdini@cats.com',
                            subject: 'hai!', body: 'I can haz cheezburger?'
                       )
  ContactsMailer.contact_form(contact_form)
end
