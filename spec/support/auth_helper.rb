module AuthHelper
  def http_login
    name = Auth.username
    password = Auth.password
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(name, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(name, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(name, password)
    elsif page.driver.browser.respond_to?(:authenticate)
      page.driver.browser.authenticate(name, password)
    else
      page.driver.headers = { 'Authorization' => "Basic #{auth_string}" }
    end
  end

  def auth_string
    ["#{Auth.username}:#{Auth.password}"].pack("m*")
  end
end
