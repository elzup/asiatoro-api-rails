module V1
  class UsersController < Grape::API
    helpers do
      def current_user
        return @current_user if @current_user
        auth_key = request.headers['Authorization']
        _, user_id, key = auth_key.split(':')
        user = User.find(user_id)
        if user.token != key
          user = nil
        end
        @current_user = user
      end

      def authenticate!
        error!('Unauthorized: 不正なユーザです。', 401) unless current_user
      end
    end

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

      desc 'PUT /users'
      params do
        optional :name, type: String
        optional :fcm_token, type: String
      end
      put do
        authenticate!
        unless params[:name].nil?
          error!('Bad Request: ユーザ名はすでに取得されています。', 400) if User.find_by_name(params[:name])
          current_user.update(name: params[:name])
        end
        unless params[:fcm_token].nil?
          current_user.update(fcm_token: params[:fcm_token])
        end
        status 201
        present current_user, with: Entity::UserWithTokenEntity
      end
    end
  end
end
