class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  has_many :subscriptions, dependent: :destroy

  def subscribe(user)
    subscriptions.create(user_id: user.id, user_role: 1)
  end

  def owner
    _owner = subscriptions.where(user_role: 1).first
    _owner &&= _owner.user
  end

  # Include room owner
  def serializable_hash(options={})
    super.merge!({owner: owner})
  end
end
