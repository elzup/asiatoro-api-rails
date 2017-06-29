
module RequestsHelper
  def get_with_token(path, params={}, headers={}, user=nil)
    headers.merge!('HTTP_AUTHORIZATION' => retrieve_access_token(user))
    get path, params: params[:params] || params, headers: headers
  end

  def post_with_token(path, params={}, headers={}, user=nil)
    headers.merge!('HTTP_AUTHORIZATION' => retrieve_access_token(user))
    post path, params: params[:params] || params, headers: headers
  end

  def put_with_token(path, params={}, headers={}, user=nil)
    headers.merge!('HTTP_AUTHORIZATION' => retrieve_access_token(user))
    put path, params: params[:params] || params, headers: headers
  end

end