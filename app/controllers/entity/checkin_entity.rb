module Entity
  class CheckinEntity < Grape::Entity
    expose :id
    expose :user, using: Entity::UserEntity
  end
end
