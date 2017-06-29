module SessionHelper
  def retrieve_access_token(user=nil)
    if user
      return "Bearer:#{user.id}:#{user.token}"
    end
    name = 'Alice'
    pass = 'password'
    post '/v1/users', params: { name: name, pass: pass }

    expect(response.response_code).to eq 201
    parsed = JSON(response.body)
    "Bearer:1:#{parsed['token']}"
  end
end