class EmploymentTech < ActiveRecord::Base
  
  belongs_to :technology
  belongs_to :employment
  
end
