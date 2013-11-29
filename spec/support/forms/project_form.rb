class ProjectForm < Form::Base
  def initialize(&block)
    instance_eval &block
  end

  def name(value)
    fill_in 'project_name', with: value
  end

  def description(value)
    fill_in 'project_description', with: value
  end

  def short_description(value)
    fill_in 'project_short_description', with: value
  end

  def source(value)
    fill_in 'project_source', with: value
  end

  def technologies(technologies = [])
    fill_in 'project_technology_tokens', with: ids_of(technologies)
  end
end
