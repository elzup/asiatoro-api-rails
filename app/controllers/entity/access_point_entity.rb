module Entity
  class AccessPointEntity < Grape::Entity
    expose :id, :ssid, :bssid
    expose :last_checkins, using: Entity::CheckinEntity
  end
end
