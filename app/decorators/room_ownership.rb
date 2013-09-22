class RoomOwnership
  attr_reader :initial_rooms, :user

  def initialize rooms, user
    @initial_rooms = rooms
    @user  = user
  end

  def rooms
    @initial_rooms.map do |room|
      room[:owned] = true if room.owner.id == user.id
      room
    end
  end
end
