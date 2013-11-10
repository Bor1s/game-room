class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String
  field :user_id, type: String
  field :room_id, type: String

  belongs_to :user
  belongs_to :room

  validates :text, presence: true
end
