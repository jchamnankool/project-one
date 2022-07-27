class Entry < ApplicationRecord
    belongs_to :user, :optional => true
    has_many :hearts
end
