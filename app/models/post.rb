class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category_post
  has_many :comments
end
