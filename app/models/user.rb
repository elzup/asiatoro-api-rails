class User < ApplicationRecord
  has_many :follows
  has_many :access_points, through: :follows

  has_many :checkins
end
