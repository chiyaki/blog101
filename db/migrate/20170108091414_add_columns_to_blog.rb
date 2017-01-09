class AddColumnsToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :title, :string
    add_column :blogs, :description, :text
  end
end
