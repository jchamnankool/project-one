class User < ApplicationRecord
    has_secure_password
    validates :email, :uniqueness => true, :presence => true
    validates_length_of :name, :maximum => 15
    has_many :entries
    has_many :hearts
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users
end
