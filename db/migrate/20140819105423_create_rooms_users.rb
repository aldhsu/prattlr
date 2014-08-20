class CreateRoomsUsers < ActiveRecord::Migration
  def change
    create_table :rooms_users, id: false do |t|
      t.references :room
      t.references :user
    end
    add_index :rooms_users, [:room_id, :user_id]
    add_index :rooms_users, :user_id
  end
end
