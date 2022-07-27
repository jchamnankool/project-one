class User < ApplicationRecord
    has_secure_password
    validates :email, :uniqueness => true, :presence => true
    validates_length_of :name, :maximum => 15
    has_many :entries
end
