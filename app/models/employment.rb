class Employment < ActiveRecord::Base

  validates_presence_of :company, :position, :description, :start_date, :end_date

  default_scope ->{ order('start_date desc') }

  has_many :technologies, through: :employment_techs
  has_many :employment_techs
  has_many :projects

  def format_date(date_name)
    date = self.send(date_name)
    if date > DateTime.parse("1000-01-01")
      date.strftime('%b %Y')
    else
      "Current"
    end
  end

  def name
    "#{self.position} | #{self.company}"
  end

  def project_tokens=(token_string)
    self.project_ids = token_string.split(",")
  end

  def project_tokens
    self.project_ids
  end

  def technology_tokens=(token_string)
    self.technology_ids = token_string.split(",")
  end

  def technology_tokens
    self.technology_ids
  end

end
