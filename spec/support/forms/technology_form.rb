class TechnologyForm < Form::Base
  def initialize(&block)
    instance_eval &block
  end

  def name(value)
    fill_in 'technology_name', with: value
  end

  def abbreviation(value)
    fill_in 'technology_abbreviation', with: value
  end

  def description(value)
    fill_in 'technology_description', with: value
  end
end
