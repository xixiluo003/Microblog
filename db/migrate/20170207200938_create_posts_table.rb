class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :post do |t|
        t.integer :user_id
        t.string :title
        t.string :content
        t.datetime :created_at
    end
  end
end
