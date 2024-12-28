class Entry < ApplicationRecord
  belongs_to :user
  has_many :reactions
end
