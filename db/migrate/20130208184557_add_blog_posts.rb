class AddBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.integer :user_id
      t.string :slug
      t.text :text

      t.timestamps
    end
    add_index :blog_posts, :user_id
    add_index :blog_posts, :slug, :unique => true
  end
end
