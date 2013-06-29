class Technology < ActiveRecord::Base
  
  validates :name, presence: true
  validates :abbreviation, presence: true
  
  has_many :project_techs
  has_many :projects, through: :project_techs
  
end
