class UsersSerializer < ActiveModel::Serializer
  attributes :id, :spotify_id, :latitude, :longitude, :likes, :distance
  has_one :track

  def latitude
    object.location.latitude
  end

  def longitude
    object.location.longitude
  end

  def distance
    location.distance_to([options[:latitude], options[:longitude]])
  end
end
