module V1
  class WatchesController < Grape::API
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

    resource :watches do
      desc 'POST /watches'
      params do
        requires :access_point_id, type: Integer
        requires :user_id, type: Integer
      end
      post do
        authenticate!
        ap = AccessPoint.find(params[:access_point_id])
        user = User.find(params[:user_id])
        watch = Watch.create(source: @current_user, access_point: ap)
        user.readers << watch
        status :created
        present watch, with: Entity::WatchEntity
      end

      desc 'DELETE /watches'
      params do
        requires :access_point_id, type: Integer
        requires :user_id, type: Integer
      end
      delete do
        authenticate!
        ap = AccessPoint.find(params[:access_point_id])
        user = User.find(params[:user_id])
        watch = Watch.where(access_point: ap, target: user)
        @current_user.watches.delete(watch)

        present watch
      end
    end

  end
end
