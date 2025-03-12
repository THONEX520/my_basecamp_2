class CreateAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :attachments do |t|
      t.references :project, null: false, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
