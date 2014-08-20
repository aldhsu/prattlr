class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :topic

      t.timestamps
    end
  end
end
