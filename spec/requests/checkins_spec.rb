require 'rails_helper'

describe 'GET /v1/checkins' do
  describe ' create' do
    before do
      @ssid = 'トキワシティ'
      @bob = User.create(name: 'Bob', pass: 'pass', token: 'token')
      @bob.access_points << AccessPoint.create(ssid: @ssid)
      post_with_token('/v1/checkins', { ssid: @ssid }, {}, @bob)
    end

    it '201 OK' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it '更新される' do
      expect(@bob.checkins.last).not_to be_nil
      expect(@bob.checkins.last.access_point.ssid).to eq(@ssid)
    end
  end

  describe ' create balk' do
    before do
      @ssids = ['トキワシティ', 'ニシキタウン']
      @bob = User.create(name: 'Bob', pass: 'pass', token: 'token')
      @bob.access_points << @ssids.map { |ssid| AccessPoint.create(ssid: ssid) }
      post_with_token('/v1/checkins/balk', { ssids: @ssids }, {}, @bob)
    end

    it '201 OK' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it '更新される' do
      expect(@bob.checkins.map { |c| c.access_point.ssid }).to eq(@ssids)
    end
  end
end
