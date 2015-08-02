class Api::V1::UsersController < ApplicationController

  DEFAULT_DISTANCE = 0.05

  def index
    user = User.find_by_spotify_id(params[:spotify_id])
    return render json: {}, status: :not_found if user.nil?
    locations = Location.within(DEFAULT_DISTANCE, origin: [user.location.latitude, user.location.longitude]).all
    users = User.where(id: locations.pluck(:user_id)).where.not(id: user.id)
    render json: users, latitude: user.location.latitude, longitude: user.location.longitude, root: false
  end

  def update
    user = User.find_by_spotify_id(params[:spotify_id])
    if user.nil?
      User.create!(spotify_id: params[:spotify_id])
      track = Track.create!(user: user, spotify_id: nil)
      location = Location.create!(latitude: params[:latitude], longitude: params[:longitude], user: user)
    else
      if params[:track].present?
        if user.track.nil?
          user.track = Track.create!(track_params)
        elsif track_params[:spotify_id] != user.track.spotify_id
          user.track.update!(track_params)
        end
      end
      if params[:latitude].to_s != "0.0"
        if user.location.nil?
          user.location = Location.create!(longitude: params[:longitude], latitude: params[:latitude])
        else
          user.location.update!(longitude: params[:longitude], latitude: params[:latitude])
        end
      end
    end
    render json: {}, status: :ok
  end


  private

  def track_params
    params.require(:track).permit(:spotify_id, :name, :artist, :playing)
  end

end
