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
  has_many :watches, class_name: 'Watch', primary_key: 'id', foreign_key: 'source_id'
  has_many :readers, class_name: 'Watch', primary_key: 'id', foreign_key: 'target_id'

  has_many :checkins, :dependent => :delete_all
end
