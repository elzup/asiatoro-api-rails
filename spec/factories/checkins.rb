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

FactoryGirl.define do
  factory :checkin do
    user nil
    access_point nil
  end
end
