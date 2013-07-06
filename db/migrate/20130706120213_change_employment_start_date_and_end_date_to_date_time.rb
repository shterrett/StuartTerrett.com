class ChangeEmploymentStartDateAndEndDateToDateTime < ActiveRecord::Migration
  def up
    remove_column :employments, :start_date
    add_column :employments, :start_date, :date
    remove_column :employments, :end_date
    add_column :employments, :end_date, :date
  end
  def down
    remove_column :employments, :start_date
    add_column :employments, :start_date, :string
    remove_column :employments, :end_date
    add_column :employments, :end_date, :string
  end
end
