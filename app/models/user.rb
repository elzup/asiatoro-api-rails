# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  pass       :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :follows, :dependent => :delete_all
  has_many :access_points, through: :follows

  has_many :checkins, :dependent => :delete_all
end
