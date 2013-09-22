class Rest::RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    rooms = Room.desc(:updated_at).page(params[:page] || 1).per(5)
    decorator = RoomOwnership.new(rooms, current_user)
    r = { rooms: decorator.rooms, total: rooms.total_pages }
    respond_with r
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
