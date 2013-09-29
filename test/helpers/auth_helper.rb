module AuthHelper
  def http_login
    user = 'allinall'
    pw = 'twcollins'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end