class AboutMeForm < Form::Base
  def initialize(&block)
    instance_eval &block
  end

  def about(text)
    fill_in 'about_info', with: text
  end

  def submit
    click_button 'Update About'
  end
end
