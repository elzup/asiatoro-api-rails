# == Schema Information
#
# Table name: access_points
#
#  id         :integer          not null, primary key
#  ssid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AccessPoint < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows

  has_many :checkins

  def last_checkins
    # TODO: Eager Loading
    users.map { |u| checkins.where(user: u).order('created_at DESC').limit(1).first }
  end
end
