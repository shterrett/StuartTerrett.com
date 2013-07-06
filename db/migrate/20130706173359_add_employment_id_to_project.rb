class AddEmploymentIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :employment_id, :integer
  end
end
