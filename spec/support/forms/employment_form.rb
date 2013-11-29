class EmploymentForm < Form::Base
  def initialize(&block)
    instance_eval &block
  end

  def company(value)
    fill_in 'employment_company', with: value
  end

  def position(value)
    fill_in 'employment_position', with: value
  end

  def description(value)
    fill_in 'employment_description', with: value
  end

  def start_date(date)
    fill_in 'employment_start_date', with: formatted_date(date)
  end

  def end_date(date)
    fill_in 'employment_end_date', with: formatted_date(date)
  end

  def website(value)
    fill_in 'employment_url', with: value
  end

  def technologies(technologies)
    fill_in 'employment_technology_tokens', with: ids_of(technologies)
  end

  def projects(projects)
    fill_in 'employment_project_tokens', with: ids_of(projects)
  end

  private

  def formatted_date(date)
    date.strftime '%Y-%m-%d'
  end
end
