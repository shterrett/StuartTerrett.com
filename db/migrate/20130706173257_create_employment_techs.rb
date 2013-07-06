class CreateEmploymentTechs < ActiveRecord::Migration
  def change
    create_table :employment_techs do |t|
      t.integer :technology_id
      t.integer :employment_id

      t.timestamps
    end
  end
end
