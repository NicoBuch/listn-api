class User < ActiveRecord::Base
  has_one :location, as: :locatable
  has_one :track

  acts_as_mappable through: :location

  validates :spotify_id, uniqueness: true

end
