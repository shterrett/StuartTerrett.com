class Project < ActiveRecord::Base
  
  validates :name, presence: true
  validates :description, presence: true
  validates :short_description, presence: true
  
  has_many :project_techs
  has_many :technologies, through: :project_techs
  
  def source_link
    if self.source.downcase == "closed" || self.source.empty?
      "Closed Source"
    else
      "<a href='#{self.source}'>View Source</a>".html_safe
    end
  end
  
end
