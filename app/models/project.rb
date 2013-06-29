class Project < ActiveRecord::Base
  
  validates :name, presence: true
  validates :description, presence: true
  validates :short_description, presence: true
  
  has_many :project_techs
  has_many :technologies, through: :project_techs
end
