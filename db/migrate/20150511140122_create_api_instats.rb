class CreateAPIInstats < ActiveRecord::Migration
  def change
    create_table :api_instats do |t|
      t.timestamps null: false
    end
  end
end
