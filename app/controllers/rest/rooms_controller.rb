class Rest::RoomsController < ApplicationController
  layout false
  before_action :authenticate
  respond_to :html, :json

  def index
    authorize! :read, Room
    rooms = Room.desc(:updated_at).page(params[:page] || 1).per(5)
    decorator = RoomOwnership.new(rooms, current_user)
    r = { rooms: decorator.rooms, total: rooms.total_pages }
    respond_with r
  end

  def show
    room = Room.where(id: params[:id]).first
    if room
      decorator = RoomOwnership.new(room, current_user)
      r = { room: decorator.room,
            owned: decorator.room[:owned],
            joined: decorator.room[:joined],
            players: room.players,
            total_players: room.subscriptions.count
      }
      respond_with r
    end
  end

  def edit
    room = Room.where(id: params[:id]).first
    authorize! :manage, room
    respond_with room
  end

  def join
    room = Room.where(id: params[:id]).first
    result = room.subscribe current_user, :player
    head :created
  end

  def leave
    room = Room.where(id: params[:id]).first
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
    room = Room.where(id: params[:id]).first
    authorize! :manage, room
    room.destroy
    respond_with room
  end

  private

  def room_params
    params.require(:room).permit!
  end
end
