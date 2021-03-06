module V1
  class FollowsController < Grape::API
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

    resource :follows do
      desc 'POST /follows'
      params do
        requires :ssid, type: String
      end
      post do
        authenticate!
        ap = AccessPoint.find_or_create_by({ssid: params[:ssid]})
        ap.users << current_user unless ap.users.include? current_user
        status :created
        present current_user.access_points, with: Entity::AccessPointEntity
      end

      desc 'DELETE /follows'
      params do
        requires :ssid, type: String
      end
      delete do
        authenticate!
        ap = AccessPoint.find_or_create_by({ssid: params[:ssid]})
        ap.users.delete(current_user) if ap.users.include? current_user
        present current_user.access_points, with: Entity::AccessPointEntity
      end
    end

  end
end
