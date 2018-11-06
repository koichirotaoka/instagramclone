class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.text :content
      t.integer :user_id
      t.text :image
      
      t.timestamps
    end
  end
end
