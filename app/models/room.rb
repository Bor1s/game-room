class Room
  include Mongoid::Document
  field :title, type: String
  field :description, type: String

  has_many :subscriptions, dependent: :destroy

  def subscribe(user)
    subscriptions.create(user_id: user.id, user_role: 1)
  end
end
