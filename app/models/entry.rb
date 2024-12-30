class Entry < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :comments, dependent: :destroy
end
