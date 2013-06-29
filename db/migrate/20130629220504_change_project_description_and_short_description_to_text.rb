class ChangeProjectDescriptionAndShortDescriptionToText < ActiveRecord::Migration
  def up
    change_column :projects, :description, :text
    change_column :projects, :short_description, :text
  end
  
  def down
    change_column :projects, :description, :string
    change_column :projects, :short_description, :string
  end
end
