# == Schema Information
#
# Table name: access_points
#
#  id         :integer          not null, primary key
#  ssid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :access_point do
    ssid "MyString"
  end
end
