class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :surname
      t.date :birthday
      t.integer :height
      t.integer :weight

      t.timestamps null: false
    end
  end
end
