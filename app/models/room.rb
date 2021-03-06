class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  validates :title, presence: true
  validates :description, presence: true

  has_many :subscriptions, dependent: :destroy
  has_many :posts, dependent: :destroy

  def subscribe user, role=:player
    unless subscribed? user
      subscriptions.create!(user_id: user.id, user_role: User::ROLES[role])
    end
  end

  def redeem user
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
    super.merge!({owner: owner, posts: posts})
  end

  def subscribed? user
    subscriptions.where(user_id: user.id).first.present?
  end
end
