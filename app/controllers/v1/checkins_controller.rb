module V1
  class CheckinsController < Grape::API
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

    resource :checkins do
      desc 'POST /checkins'
      params do
        requires :ssid, type: String
        requires :bssid, type: String
      end
      post do
        authenticate!
        ap = AccessPoint.find_or_create_by({ssid: params[:ssid], bssid: params[:bssid]})
        error!('Not follow: フォローしていません。', 401) unless ap.users.include? current_user
        status :created
        checkin = ap.checkins.create(user: current_user)

        present checkin, with: Entity::CheckinEntity
      end
    end

  end
end
