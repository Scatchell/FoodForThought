include Devise::TestHelpers

Given(/^the item "([^"]*)" exists with a price of (\d+)/) do |name, price|
  Item.create!(name: name, price: price, created_at: Time.now, updated_at: Time.now, available: true, item_type: 'meat')
end

And(/^I am signed in$/) do
  @username = 'Anthony'
  email = 'ascatche@thoughtworks.com'
  password = 'password'
  User.create!(username: @username, email: email, password: password, password_confirmation: password)

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

And(/^I am on the order creation page$/) do
  visit '/'
end

When(/^I select two items on the menu$/) do
  find(:css, "#items_[value='1']").set(true)
  find(:css, "#items_[value='2']").set(true)
end

When(/^I create the order$/) do
  click_button('Create Order')
end

Then(/^I should see the order I created$/) do
  page.should have_content 'Order created for Test'
  page.should have_content 'Rice'
  page.should have_content 'Beans'

end