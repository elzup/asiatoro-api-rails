module V1
  class AccessPointsController < Grape::API
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

    resource :access_points do
      desc 'GET /access_points'
      get do
        authenticate!
        present current_user.access_points, with: Entity::AccessPointEntity
      end
    end

  end
end
