class ProjectTech < ActiveRecord::Base
  
  belongs_to :project
  belongs_to :technology
  
end
