require_relative('../../test/helpers/auth_helper')
include AuthHelper
Given (/^an admin user exists$/) do
  @username = 'Anthony'
  @email = 'ascatche@thoughtworks.com'
  @password = 'password'
  @is_admin = true
  @valid_user = User.new(username: @username, email: @email, password: @password, password_confirmation: @password, is_admin: @is_admin)
  @valid_user.save!
end

And(/^I sign in as an admin user$/) do
  visit '/users/sign_in'
  fill_in "user_email", :with => @email
  fill_in "user_password", :with => @password
  click_button "Sign in"
end

When (/^I go to the view all orders page$/)do
  visit('/orders/display_all')
end
#
#And (/^I login as an admin$/) do
#
#  #@usr = 'allinall'
#  #@pwd = 'twcollins'
#  #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(@usr, @pwd)
#  #http_login
#end

Then(/^I should see the all orders page$/) do
  #find(:xpath, "//input[@value='Delete all orders and start next day']")
  find_button('Delete all orders and start next day')
  #page.should have_content('Delete all orders and start next day')
end