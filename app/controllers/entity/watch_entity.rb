module Entity
  class WatchEntity < Grape::Entity
    expose :id
    expose :created_at
    expose :source, using: Entity::UserEntity
    expose :target, using: Entity::UserEntity
    expose :access_point, using: Entity::AccessPointEntity
  end
end
