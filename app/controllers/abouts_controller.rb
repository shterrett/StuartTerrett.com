class AboutsController < ApplicationController
  def show
    @about = About.find_or_create_by(id: 1)
  end
end
