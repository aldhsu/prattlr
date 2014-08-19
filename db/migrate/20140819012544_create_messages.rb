class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :parent_id
      t.string :content
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end
