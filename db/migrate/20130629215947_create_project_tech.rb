class CreateProjectTech < ActiveRecord::Migration
  def change
    create_table :project_techs do |t|
      t.integer :project_id
      t.integer :technology_id
    end
  end
end
