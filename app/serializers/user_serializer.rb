class UserSerializer < ActiveModel::Serializer
  attributes :id, :spotify_id, :latitude, :longitude, :likes, :distance
  has_one :track

  def latitude
    object.location.latitude
  end

  def longitude
    object.location.longitude
  end

  def distance
    a = object.location.distance_to([options[:latitude], options[:longitude]])
    "#{(a*1000).round(2)} mts"
  end
end
