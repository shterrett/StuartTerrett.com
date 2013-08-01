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
        Credentials.email_username 
      end
    end

    def email_password
      if Rails.env.production?
        ENV["email_password"]
      else
        Credentials.email_password
      end
    end

  end
end
