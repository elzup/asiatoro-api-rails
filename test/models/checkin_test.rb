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

require 'test_helper'

class CheckinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
