class CreateProjectsUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :projects_users, id: false do |t|  
      t.references :project, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
    end
  end
end
