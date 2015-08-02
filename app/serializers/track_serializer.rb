class TrackSerializer < ActiveModel::Serializer
  attributes :spotify_id, :name, :artist, :playing

end
