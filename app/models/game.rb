class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :posts, dependent: :nullify
  attr_accessible :title, :description

  validates :title, presence: true
  validates :description, presence: true
end
