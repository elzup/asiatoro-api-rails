module Entity
  class AccessPointEntity < Grape::Entity
    expose :id, :ssid
    expose :last_checkins, using: Entity::CheckinEntity
  end
end
