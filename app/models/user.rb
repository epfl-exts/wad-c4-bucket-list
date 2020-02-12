class User < ApplicationRecord
  has_many :comments
  has_many :ideas
  has_and_belongs_to_many :goals, class_name: 'Idea'
end
