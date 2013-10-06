class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  has_many :subscriptions, dependent: :destroy

  def subscribe user, role=:player
    unless subscribed? user
      subscriptions.create!(user_id: user.id, user_role: User::ROLES[role])
    end
  end

  def leave user
    _subscription = subscriptions.where(user_id: user.id).first
    subscriptions.delete _subscription
  end

  def owner
    _owner = subscriptions.where(user_role: User::ROLES[:owner]).first
    _owner &&= _owner.user
  end

  def players
    User.where :id.in => subscriptions.map(&:user_id)
  end

  # Include room owner
  def serializable_hash(options={})
    super.merge!({owner: owner})
  end

  def subscribed? user
    subscriptions.where(user_id: user.id).first.present?
  end
end
