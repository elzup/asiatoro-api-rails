class Watch < ApplicationRecord
  belongs_to :source, class_name: 'User', foreign_key: 'source_id'
  belongs_to :target, class_name: 'User', foreign_key: 'target_id'

  belongs_to :access_point
end
