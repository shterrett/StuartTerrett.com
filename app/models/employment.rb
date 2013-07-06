class Employment < ActiveRecord::Base

  validates_presence_of :company, :position, :description, :start_date, :end_date
  
  default_scope ->{ order('start_date desc') }
  
  has_many :technologies, through: :employment_techs
  has_many :employment_techs
  has_many :projects
end
