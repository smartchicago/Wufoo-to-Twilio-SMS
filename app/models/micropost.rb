class Micropost < ActiveRecord::Base
  belongs_to :user

  serialize :successIds
  serialize :problemIds

  validates :user_id, presence: true
  validates :ipc, presence: true
  validates :content, presence: true, length: { maximum: 160 }

  default_scope -> { order('microposts.created_at DESC') }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

end
