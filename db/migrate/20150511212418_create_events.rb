class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :action
      t.integer :player_id
      t.integer :half
      t.integer :second
      t.integer :pos_x
      t.integer :pos_y

      t.timestamps null: false
    end
  end
end
