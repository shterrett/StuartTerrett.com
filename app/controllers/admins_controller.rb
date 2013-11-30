class AdminsController < ApplicationController
  http_basic_authenticate_with name: Auth.username, password: Auth.password

  def show
  end
end
