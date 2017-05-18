module Entity
  class UserWithTokenEntity < Grape::Entity
    expose :id, :name, :token
  end
end
