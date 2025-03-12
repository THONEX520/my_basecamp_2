class CreateDiscussions < ActiveRecord::Migration[8.0]
  def change
    create_table :discussions do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
