# == Schema Information
#
# Table name: checkins
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  access_point_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Checkin < ApplicationRecord
  belongs_to :user
  belongs_to :access_point
end
