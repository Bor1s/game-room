class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  attr_accessible :body
end
