class AddDescriptionToDiscussionThreads < ActiveRecord::Migration[8.0]
  def change
    add_column :discussion_threads, :description, :text
  end
end
