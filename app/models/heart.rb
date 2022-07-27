class Heart < ApplicationRecord
    belongs_to :user, :optional => true
    belongs_to :entry, :optional => true
end
