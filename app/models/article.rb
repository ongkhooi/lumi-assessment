class Article < ApplicationRecord
  belongs_to :publisher

  validates :title, presence: true
  validates :published_date, presence: true
  validates :link, presence: true
end