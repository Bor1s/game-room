class Rest::RoomsController < ApplicationController
  layout false
  before_action :authenticate
  respond_to :html, :json

  def index
    authorize! :read, Room
    rooms = Room.desc(:updated_at).page(params[:page] || 1).per(5)
    if rooms.empty?
      respond_with({ success: false, message: 'Not found!' }, status: 404)
    else
      decorator = RoomOwnership.new(rooms, current_user)
      respond_with({ rooms: decorator.rooms, total: rooms.total_pages })
    end
  end

  def show
    room = Room.find(params[:id])
    decorator = RoomOwnership.new(room, current_user)
    respond_with({ room: decorator.room,
          owned: decorator.room[:owned],
          joined: decorator.room[:joined],
          players: room.players,
          total_players: room.subscriptions.count
    })
  end

  def edit
    room = Room.find(params[:id])
    authorize! :manage, room
    respond_with room
  end

  def join
    room = Room.find(params[:id])
    result = room.subscribe current_user, :player
    head :created
  end

  def leave
    room = Room.find(params[:id])
    result = room.leave current_user
    head :ok
  end

  def create
    room = Room.create(room_params)
    if room.valid?
      room.subscribe(current_user, :owner)
    end
    respond_with room, location: rest_room_url(room)
  end

  def update
    room = Room.find(params[:id])
    authorize! :manage, room
    room.update_attributes(room_params)
    respond_with room
  end

  def destroy
    room = Room.find(params[:id])
    authorize! :manage, room
    room.destroy
    head :ok
  end

  private

  def room_params
    params.require(:room).permit!
  end
end
