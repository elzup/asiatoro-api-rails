module Entity
  class UserEntity < Grape::Entity
    expose :id, :name
  end
end
