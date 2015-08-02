class Track < ActiveRecord::Base
  belongs_to :user
  validates :spotify_id, uniqueness: true

end
