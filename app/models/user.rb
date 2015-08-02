class User < ActiveRecord::Base
  has_one :location
  has_one :track

  validates :spotify_id, uniqueness: true

end
