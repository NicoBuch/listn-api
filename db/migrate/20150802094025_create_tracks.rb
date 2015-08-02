class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.string :spotify_id
      t.boolean :playing

      t.timestamps null: false
    end
  end
end
