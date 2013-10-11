module BasicHttpLoginHelper
  def login(username, password)
    page.visit("http://#{username}:#{password}@#{page.driver.rack_server.host}:#{page.driver.rack_server.port}/")
  end
end
