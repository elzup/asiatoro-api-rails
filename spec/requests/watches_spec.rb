require 'rails_helper'

describe 'GET /v1/watches' do
  describe ' create' do
    before do
      @ap = AccessPoint.create(ssid: 'トキワシティ')
      @alice = User.create(name: 'Alice', pass: 'pass', token: 'token')
      @bob = User.create(name: 'Bob', pass: 'pass', token: 'token')

      post_with_token('/v1/watches', {access_point_id: @ap.id, user_id: @bob.id}, {}, @alice)
    end

    it '201 OK' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it '更新される' do
      expect(@alice.watches.last).not_to be_nil
      expect(@alice.watches.last.access_point.ssid).to eq(@ap.ssid)
    end
  end

  describe ' destroy' do
    before do
      @ssid = 'トキワシティ'
      @bob = User.create(name: 'Bob', pass: 'pass', token: 'token')
      @alice = User.create(name: 'Alice', pass: 'pass', token: 'token')
      @ap = AccessPoint.create(ssid: @ssid)
      @bob.access_points << @ap
      delete_with_token('/v1/watches', {access_point_id: @ap.id, user_id: @bob.id}, {}, @alice)
    end

    it '204 OK' do
      expect(response).to be_success
      expect(response.status).to eq(204)
    end

    it '更新される' do
      expect(Watch.where({access_point: @ap, target: @bob}).count()).to be(0)
    end
  end
end
