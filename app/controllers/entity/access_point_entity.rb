module Entity
  class AccessPointEntity < Grape::Entity
    expose :id, :ssid
    expose :today_checkins, using: Entity::CheckinEntity
    expose :last_checkins, using: Entity::CheckinEntity
  end
end
