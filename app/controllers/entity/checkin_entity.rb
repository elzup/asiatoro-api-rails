module Entity
  class CheckinEntity < Grape::Entity
    expose :id
    expose :user, using: Entity::UserEntity
    expose :access_point, using: Entity::AccessPointEntity
  end
end
