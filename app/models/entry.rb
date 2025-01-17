class Entry < ApplicationRecord
  belongs_to :user
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :public_entries, -> { where(is_public: true) }
  scope :private_entries, -> { where(is_public: false) }

end
