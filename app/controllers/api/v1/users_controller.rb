class Api::V1::UsersController < ApplicationController

  DEFAULT_DISTANCE = 50

  def index
    user = User.find_by_spotify_id(params[:spotify_id])
    return render json: {}, status: :not_found if user.nil?
    users = User.within(DEFAULT_DISTANCE, units: :mts, origin: [user.location.latitude, user.location.longitude])
                .where.not(id: user.id)
    respond_with users, latitude: user.location.latitude, longitude: user.location.longitude
  end

  def update
    user = User.find_by_spotify_id(params[:spotify_id])
    if user.nil?
      User.create!(spotify_id: params[:spotify_id])
      track = Track.create!(user: user)
      location = Loaction.create!(latitude: params[:latitude], longitude: params[:longitude], user: user)
    else
      user.track.update! params[:track] if params[:track][:spotify_id] != user.track.spotify_id
      user.loaction.update! longitude: params[:longitude], latitude: params[:latitude]
    end
    render json: {}, status: :ok
  end

end
