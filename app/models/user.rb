class User
  include Mongoid::Document

  field :uid, type: String
  field :name, type: String

  def self.find_or_create_by_auth_hash(auth_hash)
    user = User.where(uid: auth_hash[:uid]).first
    if user
      user
    else
      User.create(uid: auth_hash[:uid], name: auth_hash[:info][:first_name])
    end
  end
end
