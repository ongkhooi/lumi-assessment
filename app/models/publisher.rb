class Publisher < ApplicationRecord
  validates :name, presence: true
  validates :language, presence: true

  has_many :articles, dependent: :destroy
end
