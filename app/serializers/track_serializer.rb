class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :playing

  def id
    object.spotify_id
  end
end
