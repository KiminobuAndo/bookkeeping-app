class UpdateCoursesForEr < ActiveRecord::Migration[7.2]
  def change
    rename_column :courses, :title, :name
    add_column :courses, :description, :text
    add_column :courses, :is_published, :boolean, null: false, default: false
  end
end
