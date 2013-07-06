class AddUrlToEmployment < ActiveRecord::Migration
  def change
    add_column :employments, :url, :string
  end
end
