class AboutOnPage < PageObject::Base
  def initialize(text)
    @text = text
  end

  def view_about
    visit about_me_path
  end

  def edit
    http_login
    visit about_edit_path
    fill_in_form
  end

  def view
    visit about_me_path
  end

  def has_body?(text)
    has_text? text
  end

  private

  def fill_in_form
    about_text = @text
    AboutMeForm.new do
      about about_text
      submit
    end
  end
end
