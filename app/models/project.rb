class Project < ActiveRecord::Base

  validates :name, presence: true
  validates :description, presence: true
  validates :short_description, presence: true

  has_many :project_techs
  has_many :technologies, through: :project_techs
  belongs_to :employment

  default_scope order(updated_at: :desc)

  def source_link
    if self.source.blank? || self.source.downcase == 'closed'
      'Closed Source'
    else
      "<a href='#{self.source}'>View Source</a>".html_safe
    end
  end

  def technology_tokens=(token_string)
    self.technology_ids = token_string.split(',')
  end

  def technology_tokens
    self.technology_ids
  end

end
