class Idea < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 75 }
  
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :users

  scope :most_recent, -> { all.order(created_at: :desc).limit(3) }

  def self.search(search_term)
    where("title LIKE ?", "%#{search_term}%").or(where("description LIKE ?", "%#{search_term}%"))
  end
end
