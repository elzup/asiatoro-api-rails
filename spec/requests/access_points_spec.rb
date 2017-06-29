require 'rails_helper'

describe 'GET /v1/access_points' do
  describe ' create' do
    before do
      @ap1 = AccessPoint.create(ssid: 'ワカバタウン')
      @ap2 = AccessPoint.create(ssid: 'ヨシノシティ')
      @ap3 = AccessPoint.create(ssid: 'キキョウシティ')
      @user = User.create(name: 'Alice', pass: 'pass', token: 'token')
      @user2 = User.create(name: 'Bob', pass: 'pass', token: 'token')
      @user.access_points << [@ap1, @ap2, @ap3]
      @user2.access_points << [@ap1, @ap2, @ap3]
      @user.checkins << Checkin.create(access_point: @ap1)
      @user.checkins << Checkin.create(access_point: @ap2)
      @user.checkins << Checkin.create(access_point: @ap3)
      @user2.checkins << Checkin.create(access_point: @ap1)
      get_with_token('/v1/access_points', {}, {}, @user)
    end

    it '200 OK' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'データの取得' do
      checkins = JSON.parse(response.body)
      expect(checkins[0]['ssid']).to eq(@ap1.ssid)
      expect(checkins[1]['ssid']).to eq(@ap2.ssid)
      expect(checkins[0]['last_checkins'].size).to eq(2)
      expect(checkins[2]['last_checkins'].size).to eq(2)
    end
  end

end
