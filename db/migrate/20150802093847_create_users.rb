class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :spotify_id
      t.string :name
      t.integer :likes, default: 0

      t.timestamps null: false
    end
  end
end
