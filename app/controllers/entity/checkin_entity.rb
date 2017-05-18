module Entity
  class CheckinEntity < Grape::Entity
    expose :id
    expose :created_at
    expose :user, using: Entity::UserEntity
  end
end
