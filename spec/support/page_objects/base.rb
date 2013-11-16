module PageObject
  class Base
    include Capybara::DSL
    include Rails.application.routes.url_helpers
    include AuthHelper
  end
end
