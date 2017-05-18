module V1
  class UsersController < Grape::API
    resource :users do
      desc 'POST /users'
      params do
        requires :name, type: String
        requires :pass, type: String
      end
      post do
        error!('Bad Request: ユーザ名はすでに取得されています。', 400) if User.find_by_name(params[:name])
        attributes = {
          name: params[:name],
          pass: params[:pass],
          token: SecureRandom.hex(8)
        }
        @user = User.create(attributes)
        present @user, with: Entity::UserWithTokenEntity
      end
    end
  end
end
