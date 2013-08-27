class Rest::RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    respond_with Room.all
  end

  def show
    room = Room.where(id: params[:id]).first
    respond_with room
  end

  def create
    room = Room.create(room_params)
    if room.valid?
      room.subscribe(current_user)
    end
    respond_with room, location: rest_room_url(room)
  end

  def update
  end

  def destroy
    room = Room.where(id: params[:id]).first
    room.destroy
    respond_with room
  end

  private

  def room_params
    params.require(:room).permit!
  end
end
