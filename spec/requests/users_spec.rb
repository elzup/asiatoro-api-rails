require 'rails_helper'

describe 'GET /v1/users' do
  describe ' create' do
    before do
      @name = 'Alice'
      @pass = 'password'
      post '/v1/users', params: {name: @name, pass: @pass}
    end

    it '201 OK' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it '結果が取得できる' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq(1)
      expect(json['name']).to eq(@name)
      expect(json['token']).not_to be_nil
      expect(json['pass']).to be_nil
    end

    it '重複エラー' do
      post '/v1/users', params: {name: @name, pass: 'hogehoge'}
      expect(response.status).to eq(400)
    end
  end

  describe 'update' do

    describe '# name' do
      before do
        @new_name = 'Alice2'
        put_with_token '/v1/users', params: {name: @new_name}
      end

      it '201 OK' do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it '更新される' do
        user = User.first
        expect(user.name).to eq(@new_name)
      end

      it '結果が取得できる' do
        json = JSON.parse(response.body)
        expect(json['name']).to eq(@new_name)
      end

    end

    it 'FCM Token' do
      token = 'token'
      put_with_token '/v1/users', params: {fcm_token: token}
      user = User.first
      expect(user.fcm_token).to eq(token)
    end

    it '重複エラー' do
      bob = User.create(name: 'BobDel', pass: 'pass', token: 'token')
      put_with_token('/v1/users', {name: 'BobDel'}, {}, bob)
      expect(response.status).to eq(400)
    end
  end
end
