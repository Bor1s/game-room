class RoomOwnership
  attr_reader :initial_rooms, :user

  def initialize object, user
    if object.is_a? Room
      @initial_room = object
    else
      @initial_rooms = object
    end
    @user = user
  end

  def rooms
    @initial_rooms.map do |room|
      owned = owned? room, user
      joined = joined? room, user.id
      room[:owned] = owned
      room[:joined] = joined
      room
    end
  end

  def room
    owned = owned? @initial_room, user
    joined = joined? @initial_room, user.id
    @initial_room[:owned] = owned
    @initial_room[:joined] = joined
    @initial_room
  end

  private

  #TODO rewrite to use user_id
  def owned? room, user
    room.owner.id == user.id
  end

  def joined? room, user_id
    room.subscriptions.where(user_id: user.id).first.present?
  end
end
