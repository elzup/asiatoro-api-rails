require 'rails_helper'

describe 'GET /v1/follows' do
  describe ' create' do
    before do
      @ssid = 'トキワシティ'
      post_with_token '/v1/follows', params: { ssid: @ssid }
    end

    it '201 OK' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it '更新される' do
      expect(@ssid).to eq(User.first.access_points.last.ssid)
    end
  end

  describe ' destroy' do
    before do
      @ssid = 'トキワシティ'
      bob = User.create(name: 'Bob', pass: 'pass', token: 'token')
      delete_with_token('/v1/follows', { ssid: @ssid }, {}, bob)
      @ap = AccessPoint.find_by_ssid(@ssid)
    end

    it '204 OK' do
      expect(response).to be_success
      expect(response.status).to eq(204)
    end

    it '更新される' do
      expect(Follow.where({ access_point: @ap, user: User.first}).count()).to be(0)
    end
  end
end
