module Entity
  class AccessPointEntity < Grape::Entity
    expose :id, :ssid, :bssid
    expose :checkins, using: Entity::CheckinEntity
  end
end
