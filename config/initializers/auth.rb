module Auth
  class << self

    def username
      if Rails.env.production?
        # Heroku ENV
      else
        Credentials.username
      end
    end

    def password
      if Rails.env.production?
        # Heroku ENV
      else
        Credentials.password
      end
    end

  end
end
