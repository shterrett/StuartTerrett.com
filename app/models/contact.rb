require 'active_model'

class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :body

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :subject, presence: true
  validates :body, presence: true

  def initialize(values = {})
    self.name = values[:name]
    self.email = values[:email]
    self.subject = values[:subject]
    self.body = values[:body]
  end

end
