class Subscription
  include Mongoid::Document
  field :user_id, type: String
  field :room_id, type: String
  field :user_role, type: Integer

  belongs_to :user
  belongs_to :room
end
