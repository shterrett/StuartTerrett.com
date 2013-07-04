class AddDescriptionToTechnologies < ActiveRecord::Migration
  def change
    add_column :technologies, :description, :text
  end
end
