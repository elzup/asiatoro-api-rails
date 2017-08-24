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

      def create_checkin(ap, user)
        checkin = ap.checkins.build(user: user)
        try = 0
        begin
          checkin.save!
        rescue
          sleep 2
          try += 1
          retry if try < 10
          return nil
        end
        topic = "#{user.id}.#{ap.id}"
        fcmPushTopic(topic)
        checkin
      end

      def fcmPushTopic(topic)
        fcm = FCM.new(Rails.application.secrets.fcm_key)
        fcm.send_with_notification_key(topic)
      end
    end


    resource :checkins do
      desc 'POST /checkins'
      params do
        requires :ssid, type: String
      end
      post do
        authenticate!
        ap = AccessPoint.find_by_ssid(params[:ssid])
        error!('Not follow: フォローしていません。', 401) unless ap.users.include? current_user
        checkin = create_checkin(ap, current_user)
        error!('Any error: チェックインできません。', 500) unless checkin
        status :created
        present checkin, with: Entity::CheckinEntity
      end

      desc 'POST /checkins'
      params do
        requires :ssids, type: Array[String]
      end
      post 'balk' do
        authenticate!
        aps = params[:ssids].map {|ap| AccessPoint.find_by_ssid(ap)}
        error!('Not found: アクセスポイントが見つかりません。', 404) if aps.include?(nil)
        error!('Not follow: フォローしていません。', 401) if aps.any? {|ap| !ap.users.include? current_user}
        checkins = aps.map {|ap| create_checkin(ap, current_user)}
        error!('Any error: チェックインできません。', 500) if checkins.include?(nil)
        status :created
      end
    end
  end
end
