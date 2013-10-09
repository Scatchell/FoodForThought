include Devise::TestHelpers

Given(/^the item "([^"]*)" exists with a price of (\d+)/) do |name, price|
  item = Item.create!(name: name, price: price, created_at: Time.now, updated_at: Time.now, available: true, item_type: 'meat')

  item.save
end

And(/^I am signed in$/) do
  @username = 'Anthony'
  email = 'ascatche@thoughtworks.com'
  password = 'password'
  User.new(username: @username, email: email, password: password, password_confirmation: password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

When(/^I am on the create an order page$/) do
  visit '/'
end

When(/^I select the only available item$/) do
  check('I want')
end

And(/^I create the order$/) do
  click_button('Create Order')
end

Then(/^I should see a confirmation page showing the "(.*?)" item$/) do |item_name|
  page.should have_content "Order created for #{@username}"
  page.should have_content item_name
  page.should have_content 'Total price for this order: 5,000'
end