module Auth
  class << self

    def username
      if Rails.env.production?
        "admin" 
      else
        Credentials.username
      end
    end

    def password
      if Rails.env.production?
        ENV["admin_password"] 
      else
        Credentials.password
      end
    end
    
    def email_username
      if Rails.env.production?
        "website"
      else
        ENV["email_password"]
      end
    end

  end
end
